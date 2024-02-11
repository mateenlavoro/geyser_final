#!/usr/bin/env bash

set -e
sudo /etc/init.d/postgresql start
PGPASSWORD=solana psql -U solana -p 5433 -h localhost -w -d solana -f scripts/create_schema.sql


# Path: ci/start_progress.sh
# Questo script Bash, chiamato start-progress.sh, avvia il servizio PostgreSQL utilizzando il comando /etc/init.d/postgresql start. Quindi esegue un'istanza di psql per connettersi al database PostgreSQL con le seguenti impostazioni:
#
# Username: solana
# Password: solana
# Porta: 5432
# Host: localhost
# Database: solana
# Successivamente, viene eseguito il file create_schema.sql situato nella cartella scripts. Questo file SQL viene eseguito per creare lo schema del database, che presumibilmente è necessario per il progresso successivo dell'applicazione o del sistema.


