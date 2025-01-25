-- Création de l'utilisateur PostgreSQL (si nécessaire)
DO
$$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = '${POSTGRES_USER}') THEN
        CREATE ROLE ${POSTGRES_USER} WITH LOGIN PASSWORD '${POSTGRES_PASSWORD}';
    END IF;
END
$$;

-- Création de la base de données (si elle n'existe pas déjà)
DO
$$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = '${DB_DEV_NAME}') THEN
        CREATE DATABASE ${DB_DEV_NAME} OWNER ${POSTGRES_USER};
    END IF;
END
$$;

-- Connexion à la base de données pour configurer les extensions
\connect ${DB_DEV_NAME}

-- Création du schéma et installation des extensions dans la base Rails
CREATE SCHEMA IF NOT EXISTS postgis;
DROP EXTENSION IF EXISTS postgis CASCADE;
CREATE EXTENSION IF NOT EXISTS postgis SCHEMA postgis;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA postgis;
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA postgis;
CREATE EXTENSION IF NOT EXISTS "unaccent" WITH SCHEMA postgis;
CREATE EXTENSION IF NOT EXISTS "pg_trgm" WITH SCHEMA postgis;
