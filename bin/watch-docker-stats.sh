#!/usr/bin/env bash

_tmp_file=$(mktemp /tmp/watch-docker-stats.XXXXXX)

sigint_handler() {
  local _output_file=watch-docker-stats.$(date -u +"%Y-%m-%dT%H-%M-%SZ").txt

  mv "${_tmp_file}" "${_output_file}"
  echo "see: ${_output_file}"

  exit 0
}

trap sigint_handler INT

while true; do
  (
    docker stats --all --no-stream
    date -u +"%Y-%m-%dT%H:%M:%SZ"
  ) | tee -a ${_tmp_file}
  sleep 1
done
