#!/bin/sh -e

IDENTIFIER="${1}"
LEVEL="${2}"

if [ "${IDENTIFIER}" = '' ] || [ "${LEVEL}" = '' ]; then
    echo "Usage: ${0} IDENTIFIER LEVEL"

    exit 1
fi

echo "Enter commands:"
echo trust
echo "${LEVEL}"
echo y
echo quit
gpg --edit-key "${IDENTIFIER}"
