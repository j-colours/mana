#!/usr/bin/env bash

# Mana
# Author: jcolours
# Date: 2026-05-10
# Description: Resource Manager to streamline movement of files and the creation of them.

# Function Name: single_file
# Purpose: Whenever -s or --single flag is called run management for specfic file
# mana <file name> <new_directory>
single_file() {
  FILE=$1
  TO_DIR=$2

  # error checking for file and directory
  if [[ ! -f "$FILE" ]]; then
    echo $'\x1b[31m'"Error: File doesn't exist... Please make sure it is the correct name..."$'\x1b[0m'
    exit 1 # failure status
  fi

  if [[ ! -d "$TO_DIR" ]]; then
    mkdir -p "$TO_DIR"
  fi

  echo "$FILE --> $TO_DIR"
  mv "$FILE" "$TO_DIR"
}

# Function Name: preview_single
# Purpose: Whenever -ps or --preview-single show what would happen if single_file is used
# mana (-ps|--preview-single) <file name> <new_directory>

# Function Name: mult_files
# Purpose: Whenever -m or --mult flag is called run management for multiple files
# mana (-m|--mult) <directory> <file type/extension> <new_directory>
mult_files() {
  # recursively check a directory
  DIR=$1
  TYPE=$2
  TO_DIR=$3

  # check if directory exists because if not then create it
  if [[ ! -d "$TO_DIR" ]]; then
    mkdir -p "$TO_DIR"
  fi

  # read each file recursively found and move it to destination
  find "$DIR" -iname "*.$TYPE" | while read -r FILE; do
    echo "$FILE --> $TO_DIR"
    mv "$FILE" "$TO_DIR"
  done
}

# Funciton Name: preview_mult
# Purpose: Whenever -pm or --preview-mult is called show what would happen if mult was used
# without actually doing it
# mana (-pm|--preview-mult) <directory> <file type/extension> <new_directory>
preview_mult() {
  echo "Placeholder here..."
}

# Function Name: main
# Purpose: runs manager
main() {
  FLAG=$1
  PREVIEW=false

  case "$FLAG" in
  "-m" | "--mult")
    mult_files "$2" "$3" "$4"
    ;;
  "-s" | "--single")
    single_file "$2" "$3"
    ;;
  *)
    echo $'\x1b[31m'"Error: $FLAG is not a valid flag..."'$\x1b[0m'
    ;;
  esac

  exit 0 # success status
}

main "$@"
