#!/bin/sh -e

KEY="${1}"

if [ "${KEY}" = "" ]; then
    echo "Usage: ${0} KEY"

    exit 1
fi

gpg2 --export-secret-keys --armor "${KEY}" > private.asc
