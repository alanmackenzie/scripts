#!/bin/bash

# usage: atomic-symlink-create-or-update.sh -t target/path symlink

# This script will atomically update a symlink or simply create it if
# it does not already exist. Relinking a symlink is not an atomic operation,
# as it requires a call to rm() then to link().

# Instead we use mv as rename() is atomic.
# See: http://linux.die.net/man/2/rename

if [[ "$1" != "-t" ]]; then
  echo "Missing target flag. ./atomic-symlink-create-or-update -t target/path symlink"
  exit 1
fi

TARGET=$2
SYMLINK=$3

if [[ -z "$TARGET" || -z "$SYMLINK" ]]; then
  echo "Missing parameter. ./atomic-symlink-create-or-update -t target/path symlink"
  exit 1
fi

if [[ -h "$SYMLINK" ]]; then
  # It already exist, use mv to change the target path atomically.
  ln -s "$TARGET" "$SYMLINK-TEMP"
  mv -f -T "$SYMLINK-TEMP" "$SYMLINK" # -T causes mv to treat $DEST as a normal file.
else
  # It doesn't exist set, just a simple creation.
  ln -s "$TARGET" "$SYMLINK"
fi
