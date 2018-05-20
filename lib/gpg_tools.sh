#!/bin/sh -e

CONFIGURATION=''

while true; do
    case ${1} in
        --help)
            echo "Global usage: ${0} [--help][--configuration CONFIGURATION]"

            if command -v usage > /dev/null; then
                usage
            fi

            exit 0
            ;;
        --configuration)
            CONFIGURATION=${2-}
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

OPTIND=1

if [ "${CONFIGURATION}" = '' ]; then
    CONFIGURATION="${HOME}/.gnu-privacy-guard-tools.sh"
fi

if [ ! -f "${CONFIGURATION}" ]; then
    echo "Config missing: ${CONFIGURATION}"

    exit 1
fi

# shellcheck source=/dev/null
. "${CONFIGURATION}"

if [ "${EMAIL}" = '' ]; then
    echo "EMAIL not set."

    exit 1
fi

if [ "${KEY_SERVER}" = '' ]; then
    echo "KEY_SERVER not set."

    exit 1
fi

# TODO: Figure out how to create ~/.gnupg non-interactively before everything else.
#if [ ! -d "${HOME}/.gnupg" ]; then
#    gpg --quiet --batch
#fi
