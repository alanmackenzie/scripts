#!/bin/bash

# Remove all local branches that start with the prefix passed in ${1}.

for i in $(git branch | tr -d ' ' | egrep "^${1}")
do
  git branch -D "${i}"
done
