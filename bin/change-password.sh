#!/bin/sh -e

KEY="${1}"

if [ "${KEY}" = '' ]; then
    echo "Usage: ${0} KEY"

    exit 1
fi

echo "Enter commands:"
echo passwd
echo save
gpg --edit-key "${KEY}"
