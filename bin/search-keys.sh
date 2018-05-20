#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)

usage()
{
    echo "Usage: ${0} IDENTIFIER_OR_EMAIL"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gpg_tools.sh"
IDENTIFIER_OR_EMAIL="${1}"

if [ "${IDENTIFIER_OR_EMAIL}" = '' ]; then
    usage

    exit 1
fi

gpg --keyserver "${KEY_SERVER}" --search-keys "${IDENTIFIER_OR_EMAIL}"
