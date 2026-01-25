#!/bin/bash
# =============================================================================
# GitHub Codespaces setup script
# =============================================================================
# This script runs after the devcontainer is created to set up the dotfiles
# using chezmoi and install all necessary dependencies.

set -e

echo "🚀 Setting up dotfiles in GitHub Codespaces..."

# Install chezmoi if not already installed
if ! command -v chezmoi &> /dev/null; then
    echo "📦 Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
fi

# Initialize chezmoi with this repository
echo "🏠 Initializing chezmoi..."
if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    chezmoi init --apply --source="$PWD"
else
    echo "✓ Chezmoi already initialized"
fi

# Run the dotfiles setup script to install dependencies
if [ -f "$HOME/dotfiles.sh" ]; then
    echo "⚙️  Running dotfiles setup script..."
    chmod +x "$HOME/dotfiles.sh"
    "$HOME/dotfiles.sh" || echo "⚠️  Some setup steps may have failed, continuing..."
fi

echo "✅ Dotfiles setup complete!"
echo ""
echo "Please restart your terminal or run 'exec zsh' to apply all changes."
