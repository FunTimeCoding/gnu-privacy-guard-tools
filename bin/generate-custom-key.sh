#!/bin/sh -e

DIRECTORY=$(dirname "${0}")
SCRIPT_DIRECTORY=$(cd "${DIRECTORY}" || exit 1; pwd)
TYPE=signature

usage()
{
    echo "Usage: ${0} [--type signature|encryption]"
    echo "Default type: ${TYPE}"
}

# shellcheck source=/dev/null
. "${SCRIPT_DIRECTORY}/../lib/gpg_tools.sh"

while true; do
    case ${1} in
        --type)
            TYPE=${2-}
            shift 2
            ;;
        *)
            break
            ;;
    esac
done

if [ "${TYPE}" = signature ]; then
    COMMENT='Example signature key'
elif [ "${TYPE}" = encryption ]; then
    COMMENT='Example encryption key'
else
    usage

    exit 1
fi

SYSTEM=$(uname)

if [ "${SYSTEM}" = Darwin ]; then
    REAL_NAME=$(id -P | awk -F: '{print $8}')
else
    REAL_NAME=$(finger -m vagrant  | grep --only-match --extended-regexp 'Name: .+$')
    REAL_NAME="${REAL_NAME#Name: *}"
fi

echo "Key-Type: RSA
Key-Length: 2048
Subkey-Type: RSA
Subkey-Length: 2048
Name-Real: ${REAL_NAME}
Name-Comment: ${COMMENT}
Name-Email: example@example.org
Expire-Date: 1y
Passphrase: example" > settings.txt
cat settings.txt
echo "Continue?? [y/N]"
read -r READ

if [ ! "${READ}" = y ]; then
    exit 0
fi

gpg2 --batch --gen-key settings.txt
