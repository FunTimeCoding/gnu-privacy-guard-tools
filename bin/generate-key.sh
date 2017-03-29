#!/bin/sh -e

cat > settings.txt <<EOF
Key-Type: default
Subkey-Type: default
Name-Real: Example User
Name-Comment: Example signature key
Name-Email: example@example.org
Expire-Date: 1y
Passphrase: example
EOF

gpg2 --batch --gen-key settings.txt
