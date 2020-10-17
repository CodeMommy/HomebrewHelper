#!/bin/bash

set -e
set -u

echo "HomebrewHelper: Changing repositories to the official."
/bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/CodeMommy/HomebrewHelper@main/shell/official.sh)"

echo "HomebrewHelper: Changing uninstaller to the mirror of jsDelivr."
echo "HomebrewHelper: Starting the uninstaller."
/bin/bash -c "$(curl -fsSL 'https://cdn.jsdelivr.net/gh/Homebrew/install@master/uninstall.sh' | sed 's/https:\/\/raw.githubusercontent.com\/Homebrew\/brew\/master\//https:\/\/cdn.jsdelivr.net\/gh\/Homebrew\/brew@master\//g')"
