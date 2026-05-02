<h1 align="center">
    <a name="top" title="dotfiles">~/.&nbsp;📂</a><br/>Cross-platform, cross-shell dotfiles<br/> <sup><sub>powered by  <a href="https://www.chezmoi.io/">chezmoi</a> 🏠</sub></sup>
</h1>

[![Codacy rating][badge-codacy]][link-codacy]
[![CodeFactor rating][badge-codefactor]][link-codefactor]
[![License][badge-license]][link-license]
[![Repo analytics][badge-analytics]][link-analytics]
[![Tweet][badge-twitter]][link-twitter]

Universal command set and colourful shell configurations for Bash, Zsh and Powershell, compatible with macOS, Windows and (partially) Linux, all managed easily using [chezmoi](https://github.com/twpayne/chezmoi).

<div align="center">
    <p><strong>Be sure to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo if you find it useful! 😃</strong></p>
</div>

## Quick Start 🚀

### GitHub Codespaces ☁️

Open this repository in a GitHub Codespace to get a fully configured development environment in seconds:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main)

The Codespace will automatically:
- Install and configure zsh with Oh-My-Zsh
- Set up Powerlevel10k theme with Nerd Fonts
- Install essential plugins (autosuggestions, syntax highlighting)
- Apply all dotfiles using chezmoi
- Configure cross-platform aliases and functions

### Windows 11 & WSL2 🪟

For the best experience on Windows, we recommend using **Windows Subsystem for Linux 2 (WSL2)** with Ubuntu:

```powershell
# In PowerShell (as Administrator)
wsl --install -d Ubuntu-22.04
wsl --set-default-version 2

# After WSL restarts, inside Ubuntu
sudo apt update && sudo apt upgrade -y

# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply alicerazd/dotfiles
```

**What gets configured:**
- ✅ WSL2 with systemd support
- ✅ Windows interoperability (access Windows files and tools)
- ✅ X11 forwarding for GUI apps
- ✅ Docker Desktop integration
- ✅ 1Password SSH agent (optional)
- ✅ All DevOps tools (kubectl, terraform, docker, etc.)

### macOS & Linux 🖥️

```bash
# Install chezmoi and apply dotfiles in one command
# Replace 'alicerazd' with your GitHub username if you forked this repo
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply alicerazd/dotfiles

# Or, if you already have chezmoi installed
chezmoi init --apply alicerazd/dotfiles
```

After installation, run the setup script to install all dependencies:

```bash
~/dotfiles.sh
```

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Project goals ⚽

-   Unified set of aliases and commands.
-   Familiar feel and creature comforts across environments.
-   Cross-platform file management toolset.
-   Easy access to common paths.
-   Shortcuts to popular cross-platform apps.
-   System-agnostic `update` and `dotfiles` install commands.
-   A pretty interface! 💃
-   **Ready-to-go DevOps workstation setup** for infrastructure engineers.
-   **Secure secrets management** with 1Password integration.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## 1Password Integration 🔐

This dotfiles setup includes optional **1Password** integration for secure secrets management:

### Features

-   **SSH Agent**: Use 1Password as your SSH key provider
-   **CLI Authentication**: Seamless authentication with `op` CLI
-   **Secret References**: Reference secrets in your `.env` files
-   **Environment Variables**: Inject secrets into your shell environment

### Setup

During `chezmoi init`, you'll be prompted to enable 1Password integration. To enable it later:

```bash
chezmoi init
# Answer 'yes' when prompted for 1Password

# Sign in to 1Password
op signin

# Verify it works
op item list
```

### Usage

```bash
# Use 1Password SSH agent (auto-configured)
ssh git@github.com

# Get a secret
op item get "GitHub Token" --fields password

# Use secret references in .env files
# DATABASE_URL=op://vault/item/field
```

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## DevOps & Infrastructure Tools 🚀

This setup includes comprehensive tooling for **DevOps, Network, Systems, and Infrastructure engineers**:

### Container & Orchestration
-   **Docker** & **Docker Compose** - Container platform
-   **Kubernetes** (kubectl, helm, k9s, kubectx, kustomize) - Container orchestration
-   **Minikube** - Local Kubernetes cluster

### Infrastructure as Code
-   **Terraform** (+ terragrunt, tflint, terraform-docs) - Infrastructure provisioning
-   **Ansible** - Configuration management and automation
-   **Packer** - Machine image builder
-   **Vault** - Secrets management

### Cloud Providers
-   **AWS CLI** - Amazon Web Services
-   **Azure CLI** - Microsoft Azure
-   **Google Cloud SDK** (gcloud) - Google Cloud Platform
-   **DigitalOcean CLI** (doctl) - DigitalOcean

### Network & Monitoring
-   **Network Tools**: nmap, netcat, dnsutils, tcpdump, traceroute, arp-scan
-   **Monitoring**: htop, iotop, bandwhich, sysstat
-   **Wireshark** - Network protocol analyzer

### Version Control & CI/CD
-   **Git** (+ git-extras, git-flow, git-lfs) - Version control
-   **GitHub CLI** (gh) - GitHub from the command line
-   **Travis CI** - Continuous integration

### Shortcuts & Aliases

100+ pre-configured aliases for common tasks:

```bash
# Docker
dps     # docker ps
dexec   # docker exec -it
dlogs   # docker logs -f

# Kubernetes
k       # kubectl
kgp     # kubectl get pods
kl      # kubectl logs -f

# Terraform
tf      # terraform
tfi     # terraform init
tfp     # terraform plan

# Git
gst     # git status
glog    # git log --oneline --graph
```

See the [aliases documentation](./dot_bash_aliases) for the complete list.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Supported toolset 🛠️

Use either one or many of these, the config files will be in place and ready to provide a familiar interface.

### 🐚 Shells

-   [Bash](https://www.gnu.org/software/bash/) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS"></b>: [`~/.bashrc`](./dot_bashrc) _<sup>enhanced with [**Bash-It**](https://github.com/Bash-it/bash-it)!</sup>_
-   [PowerShell 5.1+](https://github.com/PowerShell/PowerShell) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS"></b><b title="Windows">⊞</b>: [`~/.config/powershell/`](./dot_config/powershell/) _<sup>enhanced with [**Oh-My-Posh**](https://github.com/JanDeDobbeleer/oh-my-posh), [**Terminal Icons**](https://github.com/devblackops/Terminal-Icons), and others!</sup>_
-   [Z shell](http://zsh.sourceforge.net/) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS"></b><b title="Windows (WSL)">⊞</b>: [`~/.zshrc`](./dot_zshrc) _<sup>enhanced with [**Oh-My-Zsh**](https://ohmyz.sh/), [**Powerlevel10K**](https://github.com/romkatv/powerlevel10k), and DevOps plugins!</sup>_

-   [WSL2](https://docs.microsoft.com/en-us/windows/wsl/) <b title="Windows">⊞</b>: Full Linux environment on Windows with seamless integration
### 💻 Terminals

-   [GitHub Codespaces](https://github.com/features/codespaces) ☁️ <sub><sup><b title="Linux">🐧</b></sup></sub>: [`.devcontainer/`](./.devcontainer/) _<sup>optimized for cloud development!</sup>_
-   [Hyper](https://hyper.is/) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS"></b><b title="Windows">⊞</b>: [`~/.hyper.js`](./dot_hyper.js.tmpl)
-   [iTerm2](https://iterm2.com/) <b title="macOS"></b>: [`~/.config/iterm/`](./dot_config/iterm)
-   [macOS Terminal](https://support.apple.com/en-ca/guide/terminal/welcome/mac) <b title="macOS"></b>
-   [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal-preview/9n0dx20hk701) <b title="Windows">⊞</b>: [`~/.config/windows_terminal/`](./dot_config/windows_terminal)

### 📦 Package managers

-   [Homebrew](https://brew.sh/) <b title="macOS"></b>: [`~/.Brewfile`](./dot_Brewfile)
-   [Scoop](https://scoop.sh/) <b title="Windows">⊞</b>

### 💾 Universal apps <sup><sub><b title="Linux">🐧</b></sub></sup><b title="macOS"></b><b title="Windows">⊞</b>

-   [chezmoi](https://www.chezmoi.io/) dotfiles manager: [`~/.chezmoi.toml`](./.chezmoi.toml.tmpl)
-   [cURL](https://curl.haxx.se/) data transfer tool: [`~/.curlrc`](./dot_curlrc)
-   [Git :octocat:](https://git-scm.com/) version-control system: [`~/.gitconfig`](./dot_gitconfig.tmpl)
-   [GNU Nano 4.x+](https://www.nano-editor.org/) text editor: [`~/.nanorc`](./dot_nanorc) _<sup>enhanced with [**Improved Nano Syntax Highlighting Files**](https://github.com/scopatz/nanorc)!</sup>_
-   [GNU Wget](https://www.gnu.org/software/wget/) HTTP/FTP file downloader: [`~/.wgetrc`](./dot_wgetrc)
-   [Micro](https://micro-editor.github.io/) text editor: [`~/.config/micro/`](./dot_config/micro)
-   [OpenSSH](https://www.openssh.com/) secure networking utilities: [`~/.ssh/config`](./dot_ssh/config.tmpl)
-   [Ripgrep](https://github.com/BurntSushi/ripgrep) fast-search tool: [`~/.ripgreprc`](./dot_ripgreprc)
-   [SQLite3](https://www.sqlite.org/cli.html) database client: [`~/.sqliterc`](./dot_sqliterc)
-   [Starship 🚀](https://starship.rs) cross-shell prompt: [`~/.config/starship.toml`](./dot_config/starship.toml)
-   [tmux](https://github.com/tmux/tmux/wiki) terminal multiplexer: [`~/.tmux.conf.local`](./dot_tmux.conf.local) _<sup>enhanced with [**Oh-My-Tmux**](https://github.com/gpakosz/.tmux)!</sup>_
-   [Vim](https://www.vim.org/) text editor: [`~/.vimrc`](./dot_vimrc) _<sup>enhanced with [**Ultimate vimrc**](https://github.com/amix/vimrc)!</sup>_

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Cross-shell compatibility matrix 🏁

These are unified CLI commands available amongst different shells on all platforms. While some of their outputs may differ in style between different environments, their usage and behaviours remain universal.

Additional aliases are provided by [Bash-It](https://github.com/Bash-it/bash-it/tree/master/aliases/available), [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet) and [Powershell](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_aliases), and are listed by using the command `alias`.

System-specific aliases are marked with <b title="macOS"></b>, <b title="Windows">⊞</b>, or <sub><sup><b title="Linux">🐧</b></sup></sub>.

### 🧭 Easier navigation

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅ | `~`      | Navigates to user home directory. |
| ✅   | ✅         | ✅ | `cd-`    | Navigates to last used directory. |
| ✅   | ✅         | ✅ | `..`<br>`cd..` | Navigates up a directory. |
| ✅   | ✅         | ✅ | `...`    | Navigates up two directories. |
| ✅   | ✅         | ✅ | `....`   | Navigates up three directories. |
| ✅   | ✅         | ✅ | `.....`  | Navigates up four directories. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🗂️ Directory browsing

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `l`     | Lists visible files in long format. |
| ✅   | ✅         | ✅  | `ll`    | Lists all files in long format, excluding `.` and `..`. |
| ✅   | ✅         | ✅  | `lsd`    | Lists only directories in long format. |
| ✅   | ✅         | ✅  | `lsh`   | Lists only hidden files in long format. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🗄️ File management

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `cpv`   | Copies a file securely. |
| ✅   | ✅         | ✅  | `fd`    | Finds directories. |
| ✅   | ✅         | ✅  | `ff`    | Finds files. |
| ❌   | ✅         | ❌  | `mirror` | Mirrors directories. |
| ✅   | ✅         | ✅  | `rg`    | Searches recursively with [ripgrep](https://github.com/BurntSushi/ripgrep). |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 💡 General aliases

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `alias` | Lists aliases. |
| ✅   | ✅         | ✅  | `c`     | Clears the console screen. |
| ✅   | ❌         | ✅  | `extract`<br>`x` | Extracts common file formats.<br>_Usage: `extract solarized.zip`_ |
| ✅   | ✅         | ✅  | `h`     | Displays/Searches global history.<br>_Usage: `h`_<br>_Usage: `h cd`_ |
| ✅   | ✅         | ⚠️  | `hs`    | Displays/Searches session history.<br>_Usage: `hs`_<br>_Usage: `hs cd`_ |
| ✅   | ✅         | ✅  | `mkcd`<br>`take` | Creates directory and change to it.<br>_Usage: `mkcd foldername`_ |
| ✅   | ❌         | ✅  | `reload` | Reloads the shell. |
| ✅   | ✅         | ✅  | `repeat`<br>`r` | Repeats a command `x` times.<br>_Usage: `repeat 5 echo hello`_. |
| ✅   | ❌         | ✅  | `resource` | Reloads configuration. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🕙 Time

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `now`<br>`unow` | Gets local/UTC date and time in [ISO 8601](https://xkcd.com/1179/) format `YYYY-MM-DDThh:mm:ss`. |
| ✅   | ✅         | ✅  | `nowdate`<br>`unowdate` | Gets local/UTC date in `YYYY-MM-DD` format. |
| ✅   | ✅         | ✅  | `nowtime`<br>`unowtime` | Gets local/UTC time in `hh:mm:ss` format. |
| ✅   | ✅         | ✅  | `timestamp` | Gets Unix time stamp. |
| ✅   | ✅         | ✅  | `week`  | Gets week number in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Week_dates) format `YYYY-Www`. |
| ✅   | ✅         | ✅  | `weekday` | Gets weekday number. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🌐 Networking

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `fastping` | Pings hostname(s) 30 times in quick succession. |
| ✅   | ✅         | ✅  | `flushdns` | Flushes the DNS cache. |
| ✅   | ✅         | ✅  | `ips`   | Gets all IP addresses. |
| ✅   | ✅         | ✅  | `localip` | Gets local IP address. |
| ✅   | ✅         | ✅  | `publicip` | Gets external IP address. |
| ✅   | ✅         | ✅  | `GET`<br>`HEAD`<br>`POST`<br>`PUT`<br>`DELETE`<br>`TRACE`<br>`OPTIONS` | Sends HTTP requests.<br>_Usage: `GET https://example.com` |_

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### ⚡ Power management

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `hibernate` | Hibernates the system. |
| ✅   | ✅         | ✅  | `lock`  | Locks the session. |
| ✅   | ✅         | ✅  | `poweroff` | Shuts down the system. |
| ✅   | ✅         | ✅  | `reboot` | Restarts the system. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🤓 Sysadmin

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `mnt`   | Lists drive mounts. |
| ✅   | ✅         | ✅  | `path`  | Prints each `$PATH` entry on a separate line. |
| ✅   | ✅         | ✅  | `sysinfo` | Displays information about the system.<br><strong><sup>Uses either [Winfetch](https://github.com/lptstr/winfetch), [Neofetch](https://github.com/dylanaraps/neofetch), or [Screenfetch](https://github.com/KittyKatt/screenFetch).</sup></strong> |
| ✅   | ✅         | ✅  | `top`   | Monitors processes and system resources.<br><strong><sup>Uses either [atop](https://linux.die.net/man/1/atop), [htop](https://hisham.hm/htop/), [ntop](https://github.com/Nuke928/NTop) <b title="windows">⊞</b>, or native.</sup></strong> |
| ✅   | ✅         | ✅  | `update` | Keeps all apps and packages up to date. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🖥️ Applications

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `browse` | Opens file/URL in default browser.<br>_Usage: `browse https://example.com`_ |
| ✅   | ✅         | ✅  | `chrome` | Opens file/URL in [Chrome](https://www.google.com/chrome/). |
| ✅   | ✅         | ✅  | `edge` | Opens file/URL in [Microsoft Edge](https://www.microsoft.com/en-us/edge). |
| ✅   | ✅         | ✅  | `firefox` | Opens file/URL in [Firefox](https://www.mozilla.org/en-CA/firefox/). |
| ❔   | ✅         | ❔  | `iexplore` | Opens file/URL in [Internet Explorer](https://www.microsoft.com/ie). <b title="Windows">⊞</b> |
| ✅   | ✅         | ✅  | `opera` | Opens file/URL in [Opera](https://www.opera.com/). |
| ✅   | ✅         | ✅  | `safari` | Opens file/URL in [Safari](https://www.apple.com/ca/safari/). <b title="macOS"></b> |
| ✅   | ✅         | ✅  | `ss`    | Enters the [Starship 🚀](https://starship.rs) cross-shell prompt. |
| ✅   | ✅         | ✅  | `subl`<br>`st`  | Opens in [Sublime Text](https://www.sublimetext.com/). |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 👩‍💻 Development

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `dk`    | 🐳 Alias for [`docker`](https://www.docker.com/). |
| ✅   | ✅         | ✅  | `dco`   | 🐳 Alias for [`docker-compose`](https://docs.docker.com/compose/). |
| ✅   | ✅         | ✅  | `g`     | :octocat: Alias for [`git`](https://git-scm.com/). |
| ✅   | ✅         | ✅  | `va`    | 🐍 Activates Python [virtual environment `venv`](https://docs.python.org/3/tutorial/venv.html). |
| ✅   | ✅         | ✅  | `ve`    | 🐍 Creates Python [virtual environment `venv`](https://docs.python.org/3/tutorial/venv.html). |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

###  macOS

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `hidedesktop`<br>`showdesktop` | Toggles display of desktop icons. |
| ✅   | ✅         | ✅  | `hidefiles`<br>`showfiles` | Toggles hidden files display in [Finder](https://support.apple.com/en-ca/HT201732). |
| ✅   | ✅         | ✅  | `spotoff`<br>`spoton` | Toggles [Spotlight](https://support.apple.com/en-ca/HT204014). |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### ⊞ Windows

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ❔   | ✅         | ❔  | `hidefiles`<br>`showfiles` | Toggles hidden files display in [File Explorer](https://support.microsoft.com/en-ca/help/4026617/windows-10-windows-explorer-has-a-new-name). |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 📁 Common paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `dls`   | Navigates to `~/Downloads`. |
| ✅   | ✅         | ✅  | `docs`  | Navigates to `~/Documents`. |
| ✅   | ✅         | ✅  | `dt`    | Navigates to `~/Desktop`. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 📁 Configuration paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `chezmoiconf` | Navigates to [Chezmoi](https://www.chezmoi.io/)'s local configuration repo. |
| ✅   | ✅         | ✅  | `powershellconf` | Navigates to [Powershell](https://github.com/PowerShell/PowerShell)'s profile location. |
| ✅   | ✅         | ✅  | `sublimeconf` | Navigates to [Sublime Text](https://www.sublimetext.com/)'s local configuration repo. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 📁 Custom paths

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `archives` | Navigates to `~/Archives`. |
| ✅   | ✅         | ✅  | `repos` | Navigates to `~/Code`. |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 🌱 Varia

| Bash | PowerShell | Zsh | Command | Description |
|:----:|:----------:|:---:|---------|-------------|
| ✅   | ✅         | ✅  | `cb`    | 📋 Copies contents to the clipboard. |
| ✅   | ✅         | ✅  | `cbpaste` | 📋 Pastes the contents of the clipboard. |
| ✅   | ✅         | ✅  | `md5sum` | #️⃣ Calculates MD5 hashes. |
| ✅   | ✅         | ✅  | `sha1sum`  | #️⃣ Calculates SHA1 hashes. |
| ✅   | ✅         | ✅  | `sha256sum` | #️⃣ Calculates SHA256 hashes. |
| ✅   | ✅         | ✅  | `forecast` | 🌤️ Displays [detailed weather and forecast](https://wttr.in/?n). |
| ✅   | ✅         | ✅  | `weather` | 🌤️ Displays [current weather](https://wttr.in/?format=%l:+(%C)+%c++%t+[%h,+%w]). |

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Inspirations 💡

-   [Digital Ocean: What are your favorite bash aliases?](https://www.digitalocean.com/community/questions/what-are-your-favorite-bash-aliases)
-   [GitHub: dotfiles](http://dotfiles.github.io/)
-   [GitHub: Jay Harris' Windows dotfiles](https://github.com/jayharris/dotfiles-windows)
-   [GitHub: Jan Moesen's dotfiles](https://github.com/janmoesen/tilde)
-   [GitHub: Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
-   [nixCraft: 30 Handy Bash Shell Aliases For Linux / Unix / Mac OS X](https://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html)

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

<p align="center"><strong>Don't forget to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo! 😃<br/><sub>Assembled with <b title="love">❤️</b> in Montréal.</sub></strong></p>

[badge-analytics]:https://img.shields.io/badge/repo%20analytics-public-informational?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDhDMTkuNSA4IDE4LjcgOS40IDE5LjEgMTAuNUwxNS41IDE0LjFDMTUuMiAxNCAxNC44IDE0IDE0LjUgMTQuMUwxMS45IDExLjVDMTIuMyAxMC40IDExLjUgOSAxMCA5QzguNiA5IDcuNyAxMC40IDguMSAxMS41TDMuNSAxNkMyLjQgMTUuNyAxIDE2LjUgMSAxOEMxIDE5LjEgMS45IDIwIDMgMjBDNC40IDIwIDUuMyAxOC42IDQuOSAxNy41TDkuNCAxMi45QzkuNyAxMyAxMC4xIDEzIDEwLjQgMTIuOUwxMyAxNS41QzEyLjcgMTYuNSAxMy41IDE4IDE1IDE4QzE2LjUgMTggMTcuMyAxNi42IDE2LjkgMTUuNUwyMC41IDExLjlDMjEuNiAxMi4yIDIzIDExLjQgMjMgMTBDMjMgOC45IDIyLjEgOCAyMSA4TTE1IDlMMTUuOSA2LjlMMTggNkwxNS45IDUuMUwxNSAzTDE0LjEgNS4xTDEyIDZMMTQuMSA2LjlMMTUgOU0zLjUgMTFMNCA5TDYgOC41TDQgOEwzLjUgNkwzIDhMMSA4LjVMMyA5TDMuNSAxMVoiIGZpbGw9IiNmZmZmZmYiIC8+PC9zdmc+&maxAge=86400

[badge-codacy]:https://app.codacy.com/project/badge/Grade/30eb39e1eb414295bcc3713755d57b1a

[badge-codefactor]:https://img.shields.io/codefactor/grade/github/renemarc/dotfiles?logo=codefactor&logoColor=white&cacheSeconds=300

[badge-license]:https://img.shields.io/github/license/renemarc/dotfiles.svg?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3LjgsMjBDMTcuNCwyMS4yIDE2LjMsMjIgMTUsMjJINUMzLjMsMjIgMiwyMC43IDIsMTlWMThINUwxNC4yLDE4QzE0LjYsMTkuMiAxNS43LDIwIDE3LDIwSDE3LjhNMTksMkMyMC43LDIgMjIsMy4zIDIyLDVWNkgyMFY1QzIwLDQuNCAxOS42LDQgMTksNEMxOC40LDQgMTgsNC40IDE4LDVWMThIMTdDMTYuNCwxOCAxNiwxNy42IDE2LDE3VjE2SDVWNUM1LDMuMyA2LjMsMiA4LDJIMTlNOCw2VjhIMTVWNkg4TTgsMTBWMTJIMTRWMTBIOFoiIGZpbGw9IiNmZmZmZmYiIC8+PC9zdmc+Cg==&maxAge=86400

[badge-twitter]:https://img.shields.io/twitter/url/http/shields.io.svg?style=social&maxAge=86400

[link-analytics]:https://repo-analytics.github.io/renemarc/dotfiles
[link-codacy]:https://www.codacy.com/gh/renemarc/dotfiles/dashboard
[link-codefactor]:https://www.codefactor.io/repository/github/renemarc/dotfiles
[link-license]:LICENSE.txt
[link-twitter]:https://twitter.com/intent/tweet?text=Cross-platform%2C%20cross-shell%20%23dotfiles%20using%20%23chezmoi&url=https://github.com/renemarc/dotfiles&via=renemarc&hashtags=Bash,PowerShell,ZSH
