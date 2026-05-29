#!/bin/bash

backup_if_exists() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p ~/dotfiles_backup
        mv "$file" ~/dotfiles_backup/
    fi
}
backup_if_exists ~/.zshrc.local
ln -sf ~/dotfiles/.zshrc.local ~/.zshrc.local

backup_if_exists ~/.aliases
ln -sf ~/dotfiles/.aliases ~/.aliases

backup_if_exists ~/.functions
ln -sf ~/dotfiles/.functions ~/.functions

backup_if_exists ~/.curlrc
ln -sf ~/dotfiles/.curlrc ~/.curlrc

backup_if_exists ~/.gitignore_global
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

mkdir -p ~/.config

# Optionally symlink zpreztorc if you customize it
# backup_if_exists ~/.zpreztorc
# ln -sf ~/dotfiles/zpreztorc ~/.zpreztorc

# Symlink everything from dotfiles/config/ into ~/.config/
for item in ~/dotfiles/config/*; do
    if [ -e "$item" ]; then
        basename=$(basename "$item")
        backup_if_exists ~/.config/"$basename"
        ln -sf "$item" ~/.config/"$basename"
        echo "Linked ~/.config/$basename"
    fi
done

# Ghostty custom themes (Ghostty looks in ~/.local/share/ghostty/themes/)
mkdir -p ~/.local/share/ghostty/themes
for theme in ~/dotfiles/config/ghostty/themes/*; do
    [ -e "$theme" ] && ln -sf "$theme" ~/.local/share/ghostty/themes/
done

# tmux secondary files (sourced by ~/.config/tmux/tmux.conf)
echo "→ tmux secondary files"
mkdir -p ~/.tmux
ln -sf ~/dotfiles/config/tmux/base.conf           ~/.tmux/base.conf
ln -sf ~/dotfiles/config/tmux/keys-gmux.conf      ~/.tmux/keys-gmux.conf
ln -sf ~/dotfiles/config/tmux/keys-vanilla.conf   ~/.tmux/keys-vanilla.conf
ln -sf ~/dotfiles/config/tmux/scripts             ~/.tmux/scripts

# Homebrew
echo "Installing Homebrew packages..."
brew bundle install --file=~/dotfiles/Brewfile

read -p "Restart shell now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec zsh
else
    echo "Run 'exec zsh' or restart your terminal when ready."
fi
