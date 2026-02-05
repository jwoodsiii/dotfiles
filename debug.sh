#!/bin/bash
# Add verbose logging to your .zshrc.local
cat > ~/dotfiles/.zshrc.local << 'EOF'
echo "=== Starting .zshrc.local ==="

echo "Loading Homebrew..."
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Starting ssh-agent..."
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi
ssh-add --apple-load-keychain 2>/dev/null

echo "Sourcing aliases..."
[[ -f ~/dotfiles/.aliases ]] && source ~/dotfiles/.aliases

echo "Sourcing functions..."
[[ -f ~/dotfiles/.functions ]] && source ~/dotfiles/.functions

echo "=== Finished .zshrc.local ==="
EOF
