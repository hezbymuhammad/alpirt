# README

## Requirement

Docker 27.5.1

Docker Compose v2.32.4

## Stack

Ruby 3.4.2

Rails 8.0.1

Postgres 14 primary-replica

Redis cache

## Setup

Run below script

```bash
docker compose up -d postgres_primary postgres_replica
docker compose run tripla bash -c "bundle exec rails db:create:primary"
docker compose run tripla bash -c "bundle exec rails db:migrate:primary"
docker compose run tripla bash -c "bundle exec rails db:seed"
docker compose run tripla bash -c "bundle exec rails db:create RAILS_ENV=test"
docker compose run tripla bash -c "bundle exec rails db:migrate RAILS_ENV=test"
```

## Run

Your server will run at http://localhost:3000

```bash
docker compose up tripla
```

## Postman

v2.1 collection [here](https://github.com/hezbymuhammad/alpirt/raw/refs/heads/main/Tripla.postman_collection.json)
