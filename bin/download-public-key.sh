#!/bin/sh -e

KEY="${1}"

if [ "${KEY}" = '' ]; then
    echo "Usage: ${0} KEY"

    exit 1
fi

gpg --keyserver keyserver.ubuntu.com --recv "${KEY}"
gpg --export --armor "${KEY}" > public.asc
bin/export-public-key.sh "${KEY}"
gpg --delete-key "${KEY}"
