#!/bin/bash

LIGHT_CYAN='\033[106m'
NO_COLOR='\033[0m'
PACKAGE_LOCK_FILE=package-lock.json

if test -f "$PACKAGE_LOCK_FILE"; then
  echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} 🔨 NPM Clean Installing..."
  npm ci
else
  echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} 🔨 NPM Installing..."
  npm install
fi

echo -e "${LIGHT_CYAN}[🌊 RapidKit]${NO_COLOR} ✨ NPM installed! ✨"