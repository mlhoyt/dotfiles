#!/usr/bin/env bash

set -E -o errexit -o nounset -o pipefail
trap "echo Error encountered -- exiting!" ERR

_outfile=${1:-${HOME}/dotfiles/atom/packages.list}

(
  for jsonFile in ${HOME}/.atom/packages/*/package.json
  do
    cat ${jsonFile} | jq -r '._id'
  done
) | sort > ${_outfile}
