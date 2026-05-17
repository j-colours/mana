#!/usr/bin/env bash

# love2d_conf
# Author: jcolours
# Date: 2026-05-16
# Description: Module to move some clutter from mana.sh

main() {
  touch -a conf.lua
  echo "--- conf.lua" >>conf.lua
  echo "--- Description: This file configures some of the game settings" >>conf.lua

  echo >>conf.lua

  echo "function love.conf(t)" >>conf.lua
  echo -e "\tt.window.width = 1024" >>conf.lua
  echo -e "\tt.window.height = 768" >>conf.lua
  echo "end" >>conf.lua

  exit 0 # status success
}

main
