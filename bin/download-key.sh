#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
DELETE=false

usage()
{
    echo "Usage: ${0} [--delete] IDENTIFIER"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gpg_tools.sh"

while true; do
    case ${1} in
        --delete)
            DELETE=true
            shift
            ;;
        *)
            break
            ;;
    esac
done

IDENTIFIER="${1}"

if [ "${IDENTIFIER}" = '' ]; then
    usage

    exit 1
fi

gpg --keyserver "${KEY_SERVER}" --recv "${IDENTIFIER}"
"${SCRIPT_DIRECTORY}/export-public-key.sh" "${IDENTIFIER}"

if [ "${DELETE}" = true ]; then
    gpg --delete-key "${IDENTIFIER}"
fi
