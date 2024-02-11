#!/usr/bin/env bash # Indica che lo script Bash deve essere eseguito utilizzando l'interprete Bash.

set -e # Imposta l'opzione di shell per terminare immediatamente se uno qualsiasi dei comandi nell'esecuzione dello script restituisce un valore di uscita diverso da zero (indicativo di un errore).

cd "$(dirname "$0")/.." # Cambia la directory di lavoro corrente nella directory genitore di quella in cui si trova lo script, in modo che lo script possa essere eseguito da qualsiasi directory.

source ./ci/rust-version.sh stable # Carica le variabili d'ambiente per la versione stabile di Rust utilizzando lo script rust-version.sh dalla directory ci.

export RUSTFLAGS="-D warnings" # Imposta le flag per il compilatore Rust affinché emetta warning dettagliati durante la compilazione.

export RUSTBACKTRACE=1 # Abilita la traccia di stack dettagliata per i crash del programma Rust.

set -x # Abilita la modalità di debug, che stampa ogni comando prima di eseguirlo.

# Build/test all host crates
cargo +"$rust_stable" build # Compila il progetto Rust utilizzando la versione stabile di Rust specificata nelle variabili d'ambiente.
cargo +"$rust_stable" test -- --nocapture # Esegue i test del progetto Rust senza catturare l'output dei test.

exit 0 # Esce dallo script con un codice di uscita di successo.
