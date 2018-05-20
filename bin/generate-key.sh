#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
TYPE=signature
COMMENT=''
PURPOSE='General purpose'
CONFIRM=false

usage()
{
    echo "Usage: ${0} [--type signature|encryption][--comment COMMENT][--confirm]"
    echo "Default type: ${TYPE}"
    echo "Default purpose: ${PURPOSE}"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gpg_tools.sh"

while true; do
    case ${1} in
        --type)
            TYPE=${2-}
            shift 2
            ;;
        --purpose)
            PURPOSE=${2-}
            shift 2
            ;;
        --confirm)
            CONFIRM=true
            shift
            ;;
        *)
            break
            ;;
    esac
done

if [ ! -f tmp/settings.txt ]; then
    if [ "${COMMENT}" = '' ]; then
        if [ "${TYPE}" = signature ]; then
            COMMENT="${PURPOSE} signature key"
        elif [ "${TYPE}" = encryption ]; then
            COMMENT="${PURPOSE} encryption key"
        else
            usage

            exit 1
        fi
    fi

    if [ "${REAL_NAME}" = '' ]; then
        SYSTEM=$(uname)

        if [ "${SYSTEM}" = Darwin ]; then
            REAL_NAME=$(id -P | awk -F: '{print $8}')
        else
            REAL_NAME=$(finger -m "${USER}" | grep --only-match --extended-regexp 'Name: .+$')
            REAL_NAME="${REAL_NAME#Name: *}"
        fi
    fi

    echo "Key-Type: RSA
Key-Length: 2048
Subkey-Type: RSA
Subkey-Length: 2048
Name-Real: ${REAL_NAME}
Name-Comment: ${COMMENT}
Name-Email: ${EMAIL}
Expire-Date: 1y
Passphrase: example" > tmp/settings.txt
fi

cd tmp

if [ "${CONFIRM}" = true ]; then
    cat settings.txt
    echo "Continue? [y/N]"
    read -r READ

    if [ ! "${READ}" = y ]; then
        echo "User abort."

        exit 1
    fi
fi

gpg --batch --gen-key settings.txt
