package config

type DBConfig struct {
	Type string `toml:"type"`
	Path string `toml:"path"`
}

func (d *DBConfig) OnChange() error {
	d.SetDefault()
	return nil
}

func (d *DBConfig) SetDefault() {
	if d.Type == "" {
		d.Type = "sqlite"
	}
	if d.Path == "" {
		d.Path = "data/goploy.db"
	}
}
