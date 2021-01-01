#!/bin/bash

set -e
set -u

MIRROR_NAME="Tsinghua University"
BREW_REPOSITORY_HOST=https://mirrors.tuna.tsinghua.edu.cn/git/homebrew
BREW_BOTTLE_HOST=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
REPOSITORIES=(core cask cask-fonts cask-drivers python science)
SHELL_CONFIGURATION_FILES=(~/.bash_profile ~/.zshrc)

brew_folder=$(brew --repo)
if [ -d "$brew_folder" ]; then
    echo "HomebrewHelper: Changing repository $brew_folder to the mirror of $MIRROR_NAME."
    git -C "$brew_folder" remote set-url origin "$BREW_REPOSITORY_HOST/brew.git"
else
    echo "HomebrewHelper: Repository $brew_folder is not exist."
fi

for repository in ${REPOSITORIES[*]}; do
    folder=$(brew --repo "homebrew/$repository")
    if [ -d "$folder" ]; then
        echo "HomebrewHelper: Changing repository $folder to the mirror of $MIRROR_NAME."
        git -C "$folder" remote set-url origin "$BREW_REPOSITORY_HOST/homebrew-$repository.git"
    else
        echo "HomebrewHelper: Repository $folder is not exist."
    fi
done

for shell_configuration_file in ${SHELL_CONFIGURATION_FILES[*]}; do
    echo "HomebrewHelper: Updating $shell_configuration_file with changing HOMEBREW_BOTTLE_DOMAIN to the mirror of $MIRROR_NAME."
    touch "$shell_configuration_file"
    sed -ie '/export HOMEBREW_BOTTLE_DOMAIN=/d' "$shell_configuration_file"
    echo "export HOMEBREW_BOTTLE_DOMAIN=$BREW_BOTTLE_HOST" >>"$shell_configuration_file"
    # shellcheck disable=SC1090
    source "$shell_configuration_file"
done
