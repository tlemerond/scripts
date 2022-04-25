#!/bin/bash
set -e
URL=$(curl -s https://golang.org/dl/ | grep '^<a class="download downloadBox" href="https://dl.google.com/go/go' | grep linux | cut -f4 -d\")
echo "$URL"
VER=$(echo "$URL" | grep -Po 'go\d(\.\d+)+')
echo "$VER"
exit
#check if we currently have this version
if [ -f "/usr/local/go/bin/go" ]; then
    if /usr/local/go/bin/go version | grep "$VER"; then
            echo "go $VER already installed, exiting"
            exit 0
    fi
fi
rm -rf /usr/local/go
echo "downloading and installing go $VER"
curl $URL | tar zxf - -C /usr/local/
echo "installed go $VER"
# which go? set path!
echo "confirming installation"
go version