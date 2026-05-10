#!/usr/bin/env bash

# Mana
# Author: jcolours
# Date: 2026-05-10
# Description: Resource Manager to streamline movement of files and the creation of them.
# mana <directory name> <extension/type of file> <new_directory destination>

# Function Name: main
# Purpose: runs manager
main() {
  # recursively check a directory
  DIR=$1
  TYPE=$2
  TO_DIR=$3

  # check if directory exists because if not then create it
  if [[ ! -d "$TO_DIR" ]]; then
    mkdir -p "$TO_DIR"
  fi

  # read each file recursively found and move it to destrination
  find "$DIR" -iname "*.$TYPE" | while read -r FILE; do
    echo "$FILE --> $TO_DIR"
    mv "$FILE" "$TO_DIR"
  done
  exit 0 # success status
}

main "$@"
