#!/bin/sh

if [[ "a" == "a" ]]; then
    echo "You are using Bash as /bin/sh"
else
    echo "This shouldn't be printed if /bin/sh isn't Bash"
fi
