#!/bin/bash

set -e
set -u

echo "HomebrewHelper: Changing HOMEBREW_CORE_GIT_REMOTE to the mirror of Tencent Cloud."
# shellcheck disable=SC2034
HOMEBREW_CORE_GIT_REMOTE=https://mirrors.cloud.tencent.com/homebrew/homebrew-core.git

echo "HomebrewHelper: Changing installer to the mirror of jsDelivr."
echo "HomebrewHelper: Changing Homebrew/brew to the mirror of Tencent Cloud in installer file."
echo "HomebrewHelper: Starting the installer."
/bin/bash -c "$(curl -fsSL 'https://cdn.jsdelivr.net/gh/Homebrew/install@master/install.sh' | sed 's/BREW_REPO=\"https:\/\/github.com\/Homebrew\/brew\"/BREW_REPO=\"https:\/\/mirrors.cloud.tencent.com\/homebrew\/brew.git\"/g')"

echo "HomebrewHelper: Changing repositories to the mirror of Tencent Cloud."
/bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/CodeMommy/HomebrewHelper@main/shell/mirror.sh)"
