#!/usr/bin/env bash

# loev2d_main
# Author: jcolours
# Date: 2026-05-16
# Description: Module to move some of the clutter from the main script mana.sh

main() {
  touch -a main.lua
  echo "--- main.lua" >>main.lua
  echo "--- Description: This is the main file that runs the game" >>main.lua

  echo >>main.lua

  echo "function love.draw()" >>main.lua
  echo -e "\tlove.graphics.print(\"Hello World!\", 400, 300)" >>main.lua
  echo "end" >>main.lua

  exit 0 # status success
}

main
