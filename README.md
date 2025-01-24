# rekylibre

New version of ekylibre with latest stack (Rails 7.1, Ruby 3.2, Postgresql 16) under Docker

## Initial setup

```
cp .env.example .env
docker compose build
docker compose run --rm web bin/rails db:setup
```

## Running the Rails app

```
docker compose up
```

## Running the Rails console

When the app is already running with `docker compose` up, attach to the container:
```
docker compose exec web bin/rails c
```

When no container running yet, start up a new one:
```
docker compose run --rm web bin/rails c
```

## Run a migration

```
docker compose run --rm web bin/rake db:migrate
```

## Running tests

```
docker compose run --rm web bin/rspec
```

## Updating gems

```
docker compose run --rm web bundle update
docker compose up --build
```
# ekylibre
