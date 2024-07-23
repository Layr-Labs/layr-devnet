#!/usr/bin/env bash

VERSION="1.14.7-aa55f5ea"
ARCH=$(uname -m)
OS=$(uname | tr '[:upper:]' '[:lower:]')

# handle apple silicon docker nonsense
# uname -m outside of docker correctly returns arm64
if [[ $ARCH == "aarch64" ]]; then
    ARCH="arm64"
fi

# tomato, potato
if [[ $ARCH == "x86_64" ]]; then
    ARCH="amd64"
fi

if [[ $ARCH != "amd64" && $ARCH != "arm64" ]]; then
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

if [[ $OS != "darwin" && $OS != "linux" ]]; then
    echo "Unsupported OS: $OS"
    exit 1
fi

curl -L https://gethstore.blob.core.windows.net/builds/geth-alltools-${OS}-${ARCH}-${VERSION}.tar.gz | tar xvz --strip-components=1 -C /usr/local/bin/
