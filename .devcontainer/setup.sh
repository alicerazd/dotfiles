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
REPO_DIR="$PWD"
if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    # Use the current workspace as the chezmoi source
    chezmoi init --source="$REPO_DIR"
else
    echo "✓ Chezmoi already initialized"
fi

# Apply the dotfiles (this runs the run_once scripts)
echo "📝 Applying dotfiles..."
chezmoi apply --force

# Run the comprehensive setup script if it exists
if [ -f "$HOME/dotfiles.sh" ]; then
    echo "⚙️  Running comprehensive dotfiles setup..."
    chmod +x "$HOME/dotfiles.sh"
    # Run it but don't fail if some parts don't work in Codespaces
    "$HOME/dotfiles.sh" 2>&1 | tee /tmp/dotfiles-setup.log || {
        echo "⚠️  Some setup steps encountered issues (see /tmp/dotfiles-setup.log)"
        echo "   This is normal in a Codespaces environment"
    }
fi

echo ""
echo "✅ Dotfiles setup complete!"
echo ""
echo "To start using zsh with all configurations:"
echo "  exec zsh"

