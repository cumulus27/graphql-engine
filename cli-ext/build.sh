#!/usr/bin/env bash

set -e
set -u

export NODE_OPTIONS="--max-old-space-size=13312"

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

rm -rf ./bin/*
pkg ./build/command.js --output ./bin/cli-ext -t node22-linux-x64,node22-macos-x64,node22-win-x64,node22-linux-arm64,node22-macos-arm64

for binary in bin/cli-ext-*; do
  if ! [[ "$binary" =~ \.sha256$ ]]; then
    source="$(basename "$binary")"
    target="$(sed "s/x64/amd64/g; s/win/windows/g; s/macos/darwin/g; s/\\.exe//g" <<< "$source")"
    if [[ "$source" != "$target" ]]; then
      mv "bin/${source}" "bin/${target}"
    fi
  fi
done
