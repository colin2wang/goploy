package config

import (
	"fmt"
	log "github.com/sirupsen/logrus"
	"gopkg.in/natefinch/lumberjack.v2"
	"io"
	"os"
	"path"
	"runtime"
	"strings"
	"time"
)

type LogConfig struct {
	Path       string `toml:"path"`
	MaxSize    int    `toml:"maxSize"`
	MaxBackups int    `toml:"maxBackups"`
	MaxAge     int    `toml:"maxAge"`
	Compress   bool   `toml:"compress"`
}

func (l *LogConfig) OnChange() error {
	l.SetDefault()
	return nil
}

func (l *LogConfig) SetDefault() {
	var logFile io.Writer
	logPathEnv := Toml.Log.Path
	if strings.ToLower(logPathEnv) == "stdout" {
		logFile = os.Stdout
	} else {
		absPath, err := filepathAbs(logPathEnv)
		if err != nil {
			fmt.Println(err.Error())
		}
		if err := os.MkdirAll(absPath, 0755); err != nil {
			panic("create log dir error: " + err.Error())
		}
		maxSize := Toml.Log.MaxSize
		if maxSize == 0 {
			maxSize = 100
		}
		maxBackups := Toml.Log.MaxBackups
		if maxBackups == 0 {
			maxBackups = 30
		}
		maxAge := Toml.Log.MaxAge
		if maxAge == 0 {
			maxAge = 30
		}
		logFile = &lumberjack.Logger{
			Filename:   path.Join(absPath, "goploy.log"),
			MaxSize:    maxSize,
			MaxBackups: maxBackups,
			MaxAge:     maxAge,
			Compress:   Toml.Log.Compress,
		}
	}
	log.SetReportCaller(true)

	log.SetFormatter(&log.TextFormatter{
		TimestampFormat: time.DateTime,
		CallerPrettyfier: func(f *runtime.Frame) (string, string) {
			return fmt.Sprintf("%s()", path.Base(f.Function)), fmt.Sprintf("%s:%d", path.Base(f.File), f.Line)
		},
	})

	log.SetOutput(logFile)

	log.SetLevel(log.TraceLevel)

}

// filepathAbs wraps filepath.Abs to avoid import cycle
func filepathAbs(fp string) (string, error) {
	if path.IsAbs(fp) {
		return fp, nil
	}
	wd, err := os.Getwd()
	if err != nil {
		return "", err
	}
	return path.Join(wd, fp), nil
}
