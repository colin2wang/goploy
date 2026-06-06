// Copyright 2022 The Goploy Authors. All rights reserved.
// Use of this source code is governed by a GPLv3-style
// license that can be found in the LICENSE file.

package model

import (
	"database/sql"
	"errors"
	"fmt"
	"github.com/hashicorp/go-version"
	"github.com/zhenorzz/goploy/config"
	"github.com/zhenorzz/goploy/database"
	"github.com/zhenorzz/goploy/internal/pkg"
	_ "modernc.org/sqlite"
	"os"
	"path"
	"sort"
	"strings"
)

// Pagination struct
type Pagination struct {
	Page  uint64 `json:"page" schema:"page"`
	Rows  uint64 `json:"rows" schema:"rows"`
	Total uint64 `json:"total" schema:"total"`
}

// state type
const (
	Fail = iota
	Success
)

// state type
const (
	Disable = iota
	Enable
)

// review state type
const (
	PENDING = iota
	APPROVE
	DENY
)

type SQLRunner struct {
	*sql.DB
	config.BaseObserver
}

func (db *SQLRunner) OnChange() error {
	return connectDB()
}

// DB init when the program start
var DB = &SQLRunner{}

func Init() {
	if err := connectDB(); err != nil {
		panic(err)
	}
	config.GetEventBus().Subscribe(config.DBEventTopic, DB)
}

func connectDB() error {
	if runner, err := Open(config.Toml.DB); err != nil {
		return err
	} else {
		DB = runner
		return nil
	}
}

func Open(dbConfig config.DBConfig) (*SQLRunner, error) {
	// Ensure the parent directory exists
	dbDir := path.Dir(dbConfig.Path)
	if dbDir != "." {
		if err := os.MkdirAll(dbDir, 0755); err != nil {
			return nil, fmt.Errorf("create db directory %s: %w", dbDir, err)
		}
	}

	db, err := sql.Open("sqlite", dbConfig.Path)
	if err != nil {
		return nil, fmt.Errorf("sqlite open: %w", err)
	}

	// ping db to make sure the db has connected
	if err = db.Ping(); err != nil {
		return nil, fmt.Errorf("sqlite ping: %w", err)
	}

	// SQLite PRAGMA settings for WAL mode and performance
	for _, pragma := range []string{
		"PRAGMA journal_mode=WAL",
		"PRAGMA busy_timeout=5000",
		"PRAGMA foreign_keys=ON",
	} {
		if _, err := db.Exec(pragma); err != nil {
			return nil, fmt.Errorf("sqlite pragma: %w", err)
		}
	}
	return &SQLRunner{DB: db}, nil
}

func (db *SQLRunner) ImportSQL(sqlPath string) error {
	sqlContent, err := database.File.ReadFile(sqlPath)
	if err != nil {
		return err
	}
	for _, query := range strings.Split(string(sqlContent), ";") {
		query = pkg.ClearNewline(query)
		if len(query) == 0 {
			continue
		}
		_, err := db.Exec(query)
		if err != nil {
			return fmt.Errorf("execute sql error: %w, sql: %s", err, query[:min(len(query), 200)])
		}
	}
	return nil
}

func Update(targetVerStr string) error {
	systemConfig, err := SystemConfig{
		Key: "version",
	}.GetDataByKey()
	if err != nil {
		return err
	}

	if systemConfig.Value == "" {
		systemConfig.Value = "0.0.1"
	}

	currentVer, err := version.NewVersion(systemConfig.Value)
	if err != nil {
		return err
	}

	targetVer, err := version.NewVersion(targetVerStr)
	if err != nil {
		return err
	}

	if ret := currentVer.Compare(targetVer); ret == 0 {
		return nil
	} else if ret == 1 {
		return errors.New("currentVer greater than targetVer")
	}

	sqlEntries, err := database.File.ReadDir(".")
	if err != nil {
		return err
	}
	var vers []*version.Version
	for _, entry := range sqlEntries {
		filename := entry.Name()
		if filename == database.GoploySQL {
			continue
		}
		ver, err := version.NewVersion(filename[0 : len(filename)-len(path.Ext(filename))])
		if err != nil {
			continue
		}
		vers = append(vers, ver)
	}

	sort.Sort(version.Collection(vers))

	for _, ver := range vers {
		if currentVer.LessThan(ver) && targetVer.GreaterThanOrEqual(ver) {
			if err := DB.ImportSQL(ver.String() + database.FileExt); err != nil {
				return err
			}
		}
	}
	println(`Update app success`)
	systemConfig.Value = targetVerStr
	return systemConfig.EditRowByKey()
}
