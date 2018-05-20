#!/bin/sh -e

IDENTIFIER="${1}"

if [ "${IDENTIFIER}" = '' ]; then
    echo "Usage: ${0} IDENTIFIER"

    exit 1
fi

echo "Enter commands:"
echo passwd
echo save
gpg --edit-key "${IDENTIFIER}"
