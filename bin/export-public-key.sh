#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
OUTPUT_FILE="${SCRIPT_DIRECTORY}/../tmp/public.asc"

usage()
{
    echo "Usage: ${0} [--output-file OUTPUT_FILE] IDENTIFIER"
    echo "Default output file: ${OUTPUT_FILE}"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gpg_tools.sh"

while true; do
    case ${1} in
        --output-file)
            OUTPUT_FILE=${2-}
            shift 2
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

if [ -f "${OUTPUT_FILE}" ]; then
    echo "Output file already exists."

    exit 1
fi

mkdir -p tmp
gpg --export --armor "${IDENTIFIER}" > "${OUTPUT_FILE}"
