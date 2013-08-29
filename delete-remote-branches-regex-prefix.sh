#!/bin/bash

# Deletes remote branches that match a prefix.

# $1 - Git remote to target.
# $2 - Prefix to match

# Example: delete-remote-branches-regex-prefix.sh origin alanmac

for i in $(git remote show "${1}" | awk '{print $1}' | egrep "^${2}")
do
  git push "${1}" ":${i}"
done
