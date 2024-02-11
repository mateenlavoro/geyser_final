#!/usr/bin/env bash # Indica che lo script Bash deve essere eseguito utilizzando l'interprete Bash.

set -ex # Imposta l'opzione di shell per terminare immediatamente se uno qualsiasi dei comandi nell'esecuzione dello script restituisce un valore di uscita diverso da zero (indicativo di un errore). La "x" stampa ogni comando prima di eseguirlo per scopi di debug.

# Aggiunge il repository PostgreSQL al file di configurazione dei repository APT (/etc/apt/sources.list.d/pgdg.list).
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
# Scarica la chiave di firma del repository PostgreSQL e la aggiunge alla lista delle chiavi autorizzate.
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Aggiorna l'elenco dei pacchetti disponibili per l'installazione.
sudo apt-get update
# Installa PostgreSQL versione 14 utilizzando il comando apt-get install.
sudo apt-get install -y postgresql-14

# Avvia il servizio PostgreSQL utilizzando il comando /etc/init.d/postgresql start.
sudo /etc/init.d/postgresql start
# Crea un nuovo utente PostgreSQL chiamato solana con privilegi di superutente e la password solana.
sudo -u postgres psql --command "CREATE USER solana WITH SUPERUSER PASSWORD 'solana';"
# Crea un nuovo database PostgreSQL chiamato solana con solana come proprietario.
sudo -u postgres createdb -O solana solana


