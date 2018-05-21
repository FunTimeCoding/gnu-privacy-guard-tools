#!/bin/sh -e

IDENTIFIER="${1}"

if [ "${IDENTIFIER}" = '' ]; then
    echo "Usage: ${0} IDENTIFIER"

    exit 1
fi

gpg --with-colons --dry-run --import-options import-show --import "${IDENTIFIER}"
