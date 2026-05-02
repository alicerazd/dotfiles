# ZSH-Quickstart-Kit Implementation via Chezmoi

## Overview

This repository implements the same functionality as the [zsh-quickstart-kit](https://github.com/unixorn/zsh-quickstart-kit) but with significant enhancements:

- ✅ Managed through [chezmoi](https://www.chezmoi.io/) for better dotfile management
- ✅ Optimized for GitHub Codespaces with one-click setup
- ✅ Cross-platform support for macOS, Linux, and cloud environments
- ✅ Automated installation with platform detection
- ✅ Cross-shell compatibility (Bash, Zsh, PowerShell)

## Features Comparison

| Feature | zsh-quickstart-kit | This Implementation |
|---------|-------------------|---------------------|
| Oh-My-Zsh | ✅ | ✅ |
| Powerlevel10k Theme | ✅ | ✅ |
| zsh-autosuggestions | ✅ | ✅ |
| zsh-syntax-highlighting | ✅ | ✅ |
| Custom aliases & functions | ✅ | ✅ Enhanced |
| Dotfile management | Manual | ✅ chezmoi |
| GitHub Codespaces | ❌ | ✅ |
| macOS support | ✅ | ✅ |
| Linux support | ✅ | ✅ Enhanced |
| Cross-shell support | Zsh only | ✅ Bash, Zsh, PowerShell |
| Automatic updates | Manual | ✅ Via chezmoi |
| Platform-specific configs | ❌ | ✅ |

## Installation Methods

### GitHub Codespaces (Recommended for Testing)

Click the badge in the README to open a pre-configured environment:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main)

### macOS or Linux

```bash
# One-line installation
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply alicerazd/dotfiles

# Then run the comprehensive setup
~/dotfiles.sh
```

## What Gets Installed

### Core Components
1. **Oh-My-Zsh** - Zsh framework
2. **Powerlevel10k** - Modern, fast theme
3. **Essential Plugins**:
   - zsh-autosuggestions - Fish-like suggestions
   - zsh-syntax-highlighting - Fish-like syntax highlighting
   - docker - Docker aliases and completions
   - extract - Archive extraction utility
   - z - Directory jumping
   - And many more...

### Additional Enhancements
- Cross-platform aliases (work on macOS, Linux, and Windows)
- Universal commands for file management, networking, and system administration
- Integration with Homebrew (macOS) and Linuxbrew
- Support for multiple version managers (asdf, nvm, pyenv, rbenv)
- Git configuration and aliases
- tmux configuration with Oh-My-Tmux
- Vim configuration with Ultimate vimrc
- And much more!

## Automated Setup Scripts

The implementation uses chezmoi's `run_once` and `run_onchange` scripts:

1. **run_once_before_install-dependencies.sh.tmpl** - Installs system packages
2. **run_once_before_setup-path.sh.tmpl** - Configures PATH
3. **run_once_install-oh-my-zsh.sh.tmpl** - Installs Oh-My-Zsh
4. **run_once_install-powerlevel10k.sh.tmpl** - Installs theme
5. **run_once_install-zsh-plugins.sh.tmpl** - Installs plugins
6. **run_once_after_set-default-shell.sh.tmpl** - Sets zsh as default
7. **run_onchange_verify-installation.sh.tmpl** - Verifies installation

## Platform-Specific Optimizations

### GitHub Codespaces
- Auto-detection via `$CODESPACES` environment variable
- Pre-configured in `.devcontainer/devcontainer.json`
- Automatic setup on container creation
- Skips unnecessary prompts for CI environments

### macOS
- Homebrew integration
- macOS-specific aliases (Spotlight, Finder, etc.)
- iTerm2 configuration

### Linux
- Multi-package manager support (apt, yum, dnf)
- Linuxbrew support for Codespaces
- Platform-specific optimizations

## Migration from zsh-quickstart-kit

If you're currently using zsh-quickstart-kit, here's how to migrate:

1. **Backup your current configuration**:
   ```bash
   cp ~/.zshrc ~/.zshrc.backup
   cp -r ~/.oh-my-zsh ~/.oh-my-zsh.backup
   ```

2. **Initialize this dotfiles repository**:
   ```bash
   chezmoi init alicerazd/dotfiles
   ```

3. **Review changes before applying**:
   ```bash
   chezmoi diff
   ```

4. **Apply the configuration**:
   ```bash
   chezmoi apply
   ```

5. **Run the setup script**:
   ```bash
   ~/dotfiles.sh
   ```

6. **Start a new shell session**:
   ```bash
   exec zsh
   ```

## Customization

All configurations are managed via chezmoi templates, making it easy to:

- Add custom aliases in `dot_bash_aliases`
- Add custom functions in `dot_bash_functions`
- Modify zsh configuration in `dot_zshrc`
- Configure platform-specific settings using chezmoi templates

## Advantages Over zsh-quickstart-kit

1. **Unified Management**: All dotfiles in one place, managed with chezmoi
2. **Cross-Platform**: Works seamlessly across different operating systems
3. **Cloud-Ready**: Optimized for GitHub Codespaces and cloud development
4. **Automated**: Installation and updates are fully automated
5. **Extensible**: Easy to customize and extend with chezmoi templates
6. **Cross-Shell**: Same aliases work in Bash, Zsh, and PowerShell
7. **Version Control**: Track changes to your dotfiles with Git
8. **Idempotent**: Safe to run installation scripts multiple times

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for:

- Bug fixes
- New features
- Documentation improvements
- Platform-specific enhancements

## License

Same as the original repository (check the LICENSE file).
