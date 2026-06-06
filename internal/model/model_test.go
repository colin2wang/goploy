package model

import (
	"github.com/zhenorzz/goploy/config"
	"github.com/zhenorzz/goploy/database"
	"os"
	"testing"
)

func TestInitDB(t *testing.T) {
	// Use a temporary file for testing
	tmpFile := "test_goploy.db"
	defer os.Remove(tmpFile)

	cfg := config.DBConfig{
		Type: "sqlite",
		Path: tmpFile,
	}
	db, err := Open(cfg)

	if err != nil {
		t.Fatal(err)
	}
	if err := db.ImportSQL(database.GoploySQL); err != nil {
		t.Fatal(err)
	}
	db.Close()
}
