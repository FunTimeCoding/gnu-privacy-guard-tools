#!/bin/sh -e

echo "Key-Type: default
Subkey-Type: default
Name-Real: Example User
Name-Comment: Example signature key
Name-Email: example@example.org
Expire-Date: 1y
Passphrase: example" > settings.txt

gpg2 --batch --gen-key settings.txt
