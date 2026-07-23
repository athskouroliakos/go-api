package main

import (
	"log"

	"github.com/athskouroliakos/go-api/internal/db"
	"github.com/athskouroliakos/go-api/internal/env"
	"github.com/athskouroliakos/go-api/internal/store"
)

func main() {
	addr := env.GetString("DB_ADDR", "postgres://admin:adminpassword@localhost/go_api_db?sslmode=disable")
	conn, err := db.New(addr, 3, 3, "15m")
	if err != nil {
		log.Fatal(err)
	}

	defer conn.Close()

	store := store.NewStorage(conn)

	db.Seed(store, conn)
}