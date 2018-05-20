#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
OUTPUT_FILE="private.asc"
INTERACTIVE=false
PASSPHRASE_FILE=''

usage()
{
    echo "Usage: ${0} [--output-file OUTPUT_FILE][--passphrase-file PASSPHRASE_FILE][--interactive] IDENTIFIER"
    echo "Default output file: ${OUTPUT_FILE}"
    echo "In non-interactive mode, the passphrase file must be specified."
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gpg_tools.sh"

while true; do
    case ${1} in
        --output-file)
            OUTPUT_FILE=${2-}
            shift 2
            ;;
        --passphrase-file)
            PASSPHRASE_FILE=${2-}
            shift 2
            ;;
        --interactive)
            INTERACTIVE=true
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

if [ "${INTERACTIVE}" = true ]; then
    gpg --export-secret-keys --armor "${IDENTIFIER}" > private.asc
else
    if [ "${PASSPHRASE_FILE}" = '' ]; then
        usage

        exit 1
    fi

    gpg --batch --passphrase-fd 1 --passphrase-file "${PASSPHRASE_FILE}" --pinentry-mode loopback --export-secret-key --armor "${IDENTIFIER}" > "${OUTPUT_FILE}"
fi
