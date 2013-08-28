#!/bin/bash

# Remove all local branches that start with a prefix.

# $1 - The prefix to match.

# Example: delete-local-branches-regex-prefix.sh alanmac

for i in $(git branch | tr -d ' ' | egrep "^${1}")
do
  git branch -D "${i}"
done
