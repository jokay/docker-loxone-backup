#!/bin/sh
set -e

# renovate: datasource=github-releases depName=cocogitto/cocogitto
COG_VERSION="7.0.0"
TMP_DIR=$(mktemp -d)

curl -L "https://github.com/cocogitto/cocogitto/releases/download/${COG_VERSION}/cocogitto-${COG_VERSION}-x86_64-unknown-linux-musl.tar.gz" |
    tar -xz -C "$TMP_DIR"

# Find the binary wherever it landed
sudo install -m 755 "$(find "$TMP_DIR" -name 'cog' -type f)" /usr/local/bin/cog

rm -rf "$TMP_DIR"

cog --version
echo "✅ cog installed."

git config core.hooksPath .githooks
echo "✅ Git hooks configured."
