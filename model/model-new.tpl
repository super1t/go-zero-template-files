func new{{.upperStartCamelObject}}Model(conn sqlx.SqlConn{{if .withCache}}, c cache.CacheConf, opts ...cache.Option{{end}}, db string) *default{{.upperStartCamelObject}}Model {
	return &default{{.upperStartCamelObject}}Model{
		{{if .withCache}}CachedConn: sqlc.NewConn(conn, c, opts...){{else}}conn:conn{{end}},
		table:      "`" + db + "`." + {{.table}},
	}
}

