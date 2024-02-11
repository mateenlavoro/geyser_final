#
# This file maintains the rust versions for use by CI.
#
# Obtain the environment variables without any automatic toolchain updating:
#   $ source ci/rust-version.sh
#
# Obtain the environment variables updating both stable and nightly, only stable, or
# only nightly:
#   $ source ci/rust-version.sh all
#   $ source ci/rust-version.sh stable
#   $ source ci/rust-version.sh nightly

# Then to build with either stable or nightly:
#   $ cargo +"$rust_stable" build
#   $ cargo +"$rust_nightly" build
#

if [[ -n $RUST_STABLE_VERSION ]]; then
  stable_version="$RUST_STABLE_VERSION"
else
  stable_version=1.73.0
fi

if [[ -n $RUST_NIGHTLY_VERSION ]]; then
  nightly_version="$RUST_NIGHTLY_VERSION"
else
  nightly_version=2023-10-05
fi


export rust_stable="$stable_version"
export rust_stable_docker_image=solanalabs/rust:"$stable_version"

export rust_nightly=nightly-"$nightly_version"
export rust_nightly_docker_image=solanalabs/rust-nightly:"$nightly_version"

[[ -z $1 ]] || (

  rustup_install() {
    declare toolchain=$1
    if ! cargo +"$toolchain" -V > /dev/null; then
      echo "$0: Missing toolchain? Installing...: $toolchain" >&2
      rustup install "$toolchain"
      cargo +"$toolchain" -V
    fi
  }

  set -e
  cd "$(dirname "${BASH_SOURCE[0]}")"
  case $1 in
  stable)
     rustup_install "$rust_stable"
     ;;
  # nightly)
  #    rustup_install "$rust_nightly"
  #   ;;
  all)
     rustup_install "$rust_stable"
     rustup_install "$rust_nightly"
    ;;
  *)
    echo "$0: Note: ignoring unknown argument: $1" >&2
    ;;
  esac
)



# Path: ci/rust-version.sh
# Questo file, chiamato rust-version.sh, definisce le versioni di Rust da utilizzare nell'ambiente di integrazione continua (CI). Le variabili $RUST_STABLE_VERSION e $RUST_NIGHTLY_VERSION possono essere impostate esternamente per sovrascrivere le versioni predefinite. Se non sono impostate, le versioni predefinite sono 1.73.0 per la versione stabile e 2023-10-05 per la versione nightly.
# Il file esporta le seguenti variabili d'ambiente:
# rust_stable: la versione stabile di Rust da utilizzare.
# rust_stable_docker_image: l'immagine Docker corrispondente alla versione stabile di Rust.
# rust_nightly: la versione nightly di Rust da utilizzare.
# rust_nightly_docker_image: l'immagine Docker corrispondente alla versione nightly di Rust.
# Inoltre, se viene fornito un argomento al file (all, stable o nightly), il file esegue l'installazione della versione corrispondente di Rust utilizzando rustup, se non è già installata, e quindi stampa la versione di Rust appena installata.
