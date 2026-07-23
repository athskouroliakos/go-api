include .envrc
MIGRATIONS_PATH = ./cmd/migrate/migrations

.PHONY: test
test:
	@go test -v ./...

.PHONY: migrate-create
migration:
	@migrate create -seq -ext sql -dir $(MIGRATIONS_PATH) $(filter-out $@,$(MAKECMDGOALS))

.PHONY: migrate-up
migrate-up:
	@migrate -path=$(MIGRATIONS_PATH) -database=$(DB_ADDR) up

.PHONY: migrate-down
migrate-down:
	@migrate -path=$(MIGRATIONS_PATH) -database=$(DB_ADDR) down $(filter-out $@,$(MAKECMDGOALS))


migrate create -seq -ext sql -dir ./cmd/migrate/migrations create_posts

migrate -path=./cmd/migrate/migrations -database="postgres://admin:adminpassword@localhost/go_api_db?sslmode=disable" up

go run cmd/migrate/seed/main.go

npx autocannon http://localhost:8080/v1/users/113 --connections 10 --duration 5 -H "Authorization: Bearer 
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJnb0FwaSIsImV4cCI6MTc
4NTA3NTMwNSwiaWF0IjoxNzg0ODE2MTA1LCJpc3MiOiJnb0FwaSIsIm5iZiI6MTc4NDgxNjEwNSwic3ViIjoxMTN9.
Es9TScazZfGBj-6m42bqlJb7OHrNGIn0uEmyPOcIbss"

go test -v ./...