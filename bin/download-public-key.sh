#!/bin/sh -e

KEY="${1}"

if [ "${KEY}" = "" ]; then
    echo "Usage: ${0} KEY"

    exit 1
fi

gpg2 --keyserver keyserver.ubuntu.com --recv "${KEY}"
gpg2 --export --armor "${KEY}" > public.asc
gpg2 --delete-key "${KEY}"
