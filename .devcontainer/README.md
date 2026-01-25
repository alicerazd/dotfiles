# GitHub Codespaces Configuration

This directory contains the development container configuration for GitHub Codespaces.

## What's Included

When you open this repository in a GitHub Codespace, you'll get:

- **Ubuntu-based container** with essential development tools
- **Zsh** configured with Oh-My-Zsh and Powerlevel10k theme
- **Essential plugins:**
  - zsh-autosuggestions (command suggestions from history)
  - zsh-syntax-highlighting (fish-like syntax highlighting)
- **Homebrew** (Linuxbrew) for package management
- **Git** and GitHub CLI pre-configured
- **All dotfiles** automatically applied via chezmoi

## Setup Process

The Codespace setup happens automatically in these stages:

1. **Container Creation**: Base image is pulled and features are installed
2. **Post-Create** (`setup.sh`): 
   - Installs chezmoi
   - Initializes dotfiles from the repository
   - Runs comprehensive setup script
3. **First Shell**: Your zsh environment is ready to use!

## Files

- `devcontainer.json`: Main configuration for the development container
- `setup.sh`: Post-creation script that sets up dotfiles

## Customization

To customize your Codespace environment:

1. Modify `devcontainer.json` to add more features or VS Code extensions
2. Update `setup.sh` to include additional setup steps
3. Modify the chezmoi scripts in the repository root to change what gets installed

## Manual Setup

If you need to re-run the setup manually:

```bash
# Re-apply dotfiles
chezmoi apply --force

# Re-run comprehensive setup
~/dotfiles.sh
```

## Troubleshooting

### Terminal doesn't show zsh theme

Try restarting the terminal or running:
```bash
exec zsh
```

### Setup script errors

Check the setup log:
```bash
cat /tmp/dotfiles-setup.log
```

Some errors in Codespaces are expected (e.g., package manager differences, sudo permissions) and don't affect the core functionality.
