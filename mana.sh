#!/usr/bin/env bash

# Mana
# Author: jcolours
# Date: 2026-05-10
# Description: Resource Manager to streamline movement of files and the creation of them.

# declare ANSI Escape Codes for colors
RESET='\x1b[0m'
RED='\x1b[31m'
GREEN='\x1b[32m'

# Function Name: single_file
# Purpose: Whenever -s or --single flag is called run management for specfic file
# mana <file name> <new_directory>
single_file() {
  FILE=$1
  TO_DIR=$2
  PREVIEW=$3

  # error checking for file and directory
  if [[ ! -f "$FILE" ]]; then
    echo
    echo -e "${RED}Error: File doesn't exist... Please make sure it is the correct name...${RESET}"
    exit 1 # failure status
  fi

  if [[ ! -d "$TO_DIR" ]]; then
    mkdir -p "$TO_DIR"
  fi

  if [[ "$PREVIEW" == true ]]; then
    echo
    echo -e "$FILE ${GREEN}-->${RESET} $TO_DIR"
  else
    echo
    echo -e "$FILE ${GREEN}-->${RESET} $TO_DIR"
    mv "$FILE" "$TO_DIR"
  fi
}

# Function Name: preview_single
# Purpose: Whenever -ps or --preview-single show what would happen if single_file is used
# mana (-ps|--preview-single) <file name> <new_directory>
preview_single() {
  FILE=$1
  TO_DIR=$2
  PREVIEW=true

  single_file "$FILE" "$TO_DIR" "$PREVIEW"
}

# Function Name: mult_files
# Purpose: Whenever -m or --mult flag is called run management for multiple files
# mana (-m|--mult) <directory> <file type/extension> <new_directory>
mult_files() {
  # recursively check a directory
  DIR=$1
  TYPE=$2
  TO_DIR=$3
  PREVIEW=$4

  # check if type exists --> sees if find returns a string of nothing
  if [[ -z "$(find "$DIR" -iname "*.$TYPE")" ]]; then
    echo
    echo -e "${RED}Error: Type doesn't exist... Please make sure it is the correct name...${RESET}"
    exit 1 # failure status
  fi

  # check if directory exists because if not then create it
  if [[ ! -d "$TO_DIR" ]]; then
    mkdir -p "$TO_DIR"
  fi

  echo

  # read each file recursively found and move it to destination
  find "$DIR" -iname "*.$TYPE" | while read -r FILE; do
    if [[ "$PREVIEW" == true ]]; then
      echo -e "$FILE ${GREEN}-->${RESET} $TO_DIR"
    else
      echo -e "$FILE ${GREEN}-->${RESET} $TO_DIR"
      mv "$FILE" "$TO_DIR"
    fi
  done
}

# Funciton Name: preview_mult
# Purpose: Whenever -pm or --preview-mult is called show what would happen if mult was used
# without actually doing it
# mana (-pm|--preview-mult) <directory> <file type/extension> <new_directory>
preview_mult() {
  DIR=$1
  TYPE=$2
  TO_DIR=$3
  PREVIEW=true

  mult_files "$DIR" "$TYPE" "$TO_DIR" "$PREVIEW"
}

# Function Name: move_all
# Purpose: -ma or --move-all moves everything in a directory into somewhere else
# mana (-ma|--move-all) <directory> <new_directory>
move_all() {
  DIR=$1
  TO_DIR=$2

  if [[ ! -d "$DIR" ]]; then
    echo -e "${RED}Error: Target Directory doesn't exist...${RESET}"
    exit 1 # failure status
  fi

  if [[ ! -d "$TO_DIR" ]]; then
    if [[ "$PREVIEW" == true ]]; then
      echo
      echo -e "${RED}CAUTION DESTINATION DOESN'T EXIST... MAKE SURE THIS IS THE DESTINATION WANTED FOR ACTUAL MOVE...${RESET}"
    else
      mkdir -p "$TO_DIR"
    fi
  fi

  echo

  find "$DIR" -type f -iname "*" | while read -r FILE; do
    if [[ "$PREVIEW" == true ]]; then
      echo -e "$FILE ${GREEN}-->${RESET} $TO_DIR"
    else
      echo -e "$FILE ${GREEN}-->${RESET} $TO_DIR"
      mv "$FILE" "$TO_DIR"
    fi
  done
}

# Function Name: preview_all
# Purpose: Whenever the flag -pa or --preview-all is used it only shows what move all would do
# mana (-pa|--preview-all) <directory> <new_directory>
preview_all() {
  DIR=$1
  TO_DIR=$2
  PREVIEW=true

  move_all "$DIR" "$TO_DIR" "$PREVIEW"
}

# Function Name: main
# Purpose: runs manager
main() {
  FLAG=$1
  PREVIEW=false

  case "$FLAG" in
  "-m" | "--mult")
    mult_files "$2" "$3" "$4" "$PREVIEW"
    ;;
  "-s" | "--single")
    single_file "$2" "$3" "$PREVIEW"
    ;;
  "-ma" | "--move-all")
    move_all "$2" "$3"
    ;;
  "-pa" | "--preview-all")
    preview_all "$2" "$3"
    ;;
  "-ps" | "--preview-single")
    preview_single "$2" "$3"
    ;;
  "-pm" | "--preview-mult")
    preview_mult "$2" "$3" "$4"
    ;;
  *)
    echo "${RED}Error: $FLAG is not a valid flag...${RESET}"
    ;;
  esac

  exit 0 # success status
}

main "$@"
