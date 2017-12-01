#!/bin/sh -e

KEY="${1}"
LEVEL="${2}"

if [ "${KEY}" = "" ] || [ "${LEVEL}" = "" ]; then
    echo "Usage: ${0} KEY LEVEL"

    exit 1
fi

echo "Enter commands:"
echo trust
echo "${LEVEL}"
echo y
echo quit
gpg2 --edit-key "${KEY}"
