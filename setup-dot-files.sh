#!/bin/bash

# Create symbolic links in ${HOME} to all files in
# ${HOME/dot-files/ that match dot-*.

for i in $(find ${HOME}/dot-files/* -maxdepth 1 -name 'dot-*')
do
  j=$(basename "${i}")
  j=".${j#dot-}"
  ln -T -v -i -s "${i}" "${HOME}/${j}"
done
