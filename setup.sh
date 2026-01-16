#!/bin/bash

backup_if_exists() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p ~/dotfiles_backup
        mv "$file" ~/dotfiles_backup/
    fi
}
backup_if_exists ~/.zshrc.local
ln -sf ~/dotfiles/zshrc.local ~/.zshrc.local

# Optionally symlink zpreztorc if you customize it
backup_if_exists ~/.zpreztorc
ln -sf ~/dotfiles/zpreztorc ~/.zpreztorc

# Homebrew
brew bundle install --file=~/dotfiles/Brewfile
