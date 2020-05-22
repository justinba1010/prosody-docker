#!/bin/bash
set -e

usermod -u "$(stat -c %u /var/lib/prosody/.)" prosody

if [[ "$1" != "prosody" ]]; then
    exec prosodyctl "$@"
    exit 0;
fi

prosodyctl register debug localhost debug
prosodyctl register debug2 localhost debug2

runuser -u prosody -- "$@"
