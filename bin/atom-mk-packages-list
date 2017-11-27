#!/usr/bin/env bash

_outfile=${1:-~/dotfiles/atom/packages.list}

grep '^[ ]*\"version"' ~/.atom/packages/*/package.json \
    | sed 's/[:\",]//g' \
    | perl -pe 's|^.*/.atom/packages/||' \
    | perl -pe 's|/package.json||' \
    | perl -nae 'print "$F[0]\@$F[2]\n";' \
    > ${_outfile}

