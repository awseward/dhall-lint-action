#!/usr/bin/env bash

set -euo pipefail

_install_dhall() {
  local dhall_haskell_ver; dhall_haskell_ver="$1"
  local bin_zip_name; bin_zip_name="dhall-${dhall_haskell_ver}-x86_64-linux.tar.bz2"

  wget "https://github.com/dhall-lang/dhall-haskell/releases/download/${dhall_haskell_ver}/${bin_zip_name}" \
    && tar -xjvf "./${bin_zip_name}" \
    && rm -rvf "./${bin_zip_name}"
  mv ./bin/dhall /bin

  which dhall
  dhall --version && dhall --help
}

_install_dhall "$1"

find . -type f -name '*.dhall' | while read -r fpath; do
  echo "${fpath}" | xargs -t dhall lint --inplace
done

git diff --color=always --exit-code
