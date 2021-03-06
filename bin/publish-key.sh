#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)

usage()
{
    echo "Usage: ${0} IDENTIFIER"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gpg_tools.sh"
IDENTIFIER="${1}"

if [ "${IDENTIFIER}" = '' ]; then
    usage

    exit 1
fi

gpg --keyserver "${KEY_SERVER}" --send-key "${IDENTIFIER}"
