#!/bin/sh
# -*-mode:sh-*- vim:ft=shell-script

# ~/dotfiles.sh
# =============================================================================
# Idempotent manual setup script to install or update shell dependencies.

set -e

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

error() {
    printf -- "%sError: $*%s\n" >&2 "$RED" "$RESET"
}

setup_color() {
    # Only use colors if connected to a terminal
    if [ -t 1 ]; then
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        # YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        BOLD=$(printf '\033[1m')
        RESET=$(printf '\033[m')
    else
        RED=""
        GREEN=""
        # YELLOW=""
        BLUE=""
        BOLD=""
        RESET=""
    fi
}

import_repo() {
    repo=$1
    destination=$2
    if uname | grep -Eq '^(cygwin|mingw|msys)'; then
        uuid=$(powershell -NoProfile -Command "[guid]::NewGuid().ToString()")
    else
        uuid=$(uuidgen)
    fi
    TMPFILE=$(mktemp /tmp/dotfiles."${uuid}".tar.gz) || exit 1
    curl -s -L -o "$TMPFILE" "$repo" || exit 1
    chezmoi import --strip-components 1 --destination "$destination" "$TMPFILE" || exit 1
    rm -f "$TMPFILE"
}

setup_dependencies() {
    [ "${DOTFILES_SKIP_BREW:-0}" = "1" ] && return 0

    printf -- "\n%sSetting up dependencies:%s\n\n" "$BOLD" "$RESET"

    # Install Homebrew packages
    if command -v brew > /dev/null; then
        printf -- "%sInstalling/updating apps using Homebrew...%s\n" "$BLUE" "$RESET"
        brew bundle --global
    fi
}

setup_prompts() {
    printf -- "\n%sSetting up shell frameworks:%s\n\n" "$BOLD" "$RESET"

    # Install Bash-it
    PACKAGE_NAME='Bash-it'
    printf -- "%sInstalling/updating %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    import_repo 'https://github.com/Bash-it/bash-it/archive/master.tar.gz' "${HOME}/.bash-it" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install Oh My Zsh
    PACKAGE_NAME='Oh My Zsh'
    printf -- "%sInstalling/updating %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    CHEZMOIPATH=$(chezmoi source-path)
    rm -rf "$CHEZMOIPATH"/dot_oh-my-zsh/plugins
    import_repo 'https://github.com/robbyrussell/oh-my-zsh/archive/master.tar.gz' "${HOME}/.oh-my-zsh" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install Zsh plugins
    PACKAGE_NAME='zsh-autosuggestions'
    printf -- "%sInstalling/updating Zsh plugin: %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    import_repo 'https://github.com/zsh-users/zsh-autosuggestions/archive/master.tar.gz' "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    PACKAGE_NAME='zsh-syntax-highlighting'
    printf -- "%sInstalling/updating Zsh plugin: %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    import_repo 'https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz' "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install Zsh themes
    PACKAGE_NAME='Powerlevel9k'
    printf -- "%sInstalling/updating Zsh theme: %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    import_repo 'https://github.com/Powerlevel9k/powerlevel9k/archive/master.tar.gz' "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel9k" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    PACKAGE_NAME='Powerlevel10k'
    printf -- "%sInstalling/updating Zsh theme: %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    import_repo 'https://github.com/romkatv/powerlevel10k/archive/master.tar.gz' "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }
}

setup_applications() {
    printf -- "\n%sSetting up CLI applications:%s\n\n" "$BOLD" "$RESET"

    # Install Oh My Tmux
    PACKAGE_NAME='Oh My Tmux'
    printf -- "%sInstalling/updating %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    import_repo 'https://github.com/gpakosz/.tmux/archive/master.tar.gz' "${HOME}/.tmux" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }
    ln -s -f -v .tmux/.tmux.conf "$HOME"

    # Install Tmux Plugin Manager
    PACKAGE_NAME='Tmux Plugin Manager'
    printf -- "%sInstalling/updating %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    CHEZMOIPATH=$(chezmoi source-path)
    mkdir -pv "$CHEZMOIPATH"/dot_tmux/plugins/tpm
    import_repo 'https://github.com/tmux-plugins/tpm/archive/master.tar.gz' "${HOME}/.tmux/plugins/tpm" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install Nano syntax highlighting files
    PACKAGE_NAME='Nano syntax highlighting'
    CHEZMOIPATH=$(chezmoi source-path)
    rm -rf "$CHEZMOIPATH"/dot_nano/nanorc
    printf -- "%sInstalling/updating %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    import_repo 'https://github.com/scopatz/nanorc/archive/master.tar.gz' "${HOME}/.nano" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install Ultimate Vim Configuration
    PACKAGE_NAME='Ultimate vimrc'
    printf -- "%sInstalling/updating %s...%s\n" "$BLUE" "$PACKAGE_NAME" "$RESET"
    import_repo 'https://github.com/amix/vimrc/archive/master.tar.gz' "${HOME}/.vim_runtime" || {
        error "import of ${PACKAGE_NAME} failed"
        exit 1
    }

    # Install micro plugins
    if command -v micro; then
        printf -- "%sInstalling/updating micro plugins...%s\n" "$BLUE" "$RESET"
        OUT_OF_DATE='installed but out-of-date'
        if  micro -plugin install filemanager | tee -a /dev/tty | grep -q "$OUT_OF_DATE"; then
            micro -plugin update  filemanager
        fi
        if  micro -plugin install manipulator | tee -a /dev/tty | grep -q "$OUT_OF_DATE"; then
            micro -plugin update  manipulator
        fi
        if  micro -plugin install misspell | tee -a /dev/tty | grep -q "$OUT_OF_DATE"; then
            micro -plugin update  misspell
        fi
        if  micro -plugin install wc | tee -a /dev/tty | grep -q "$OUT_OF_DATE"; then
            micro -plugin update  wc
        fi
    fi
}

# shellcheck source=/dev/null
setup_devtools() {
    [ "${DOTFILES_SKIP_DEVTOOLS:-0}" = "1" ] && return 0

    printf -- "\n%sSetting up development tools:%s\n\n" "$BOLD" "$RESET"

    command_exists git || {
        error "git is not installed"
        exit 1
    }

    # Install ASDF Versionn Manager
    # https://asdf-vm.com/
    if ! command -v brew > /dev/null; then
        printf -- "%sInstalling/updating ASDF Extendable Version Manager...%s\n" "$BLUE" "$RESET"
        export ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}" && (
            ASDF_NEW=false
            if [ ! -d "$ASDF_DIR" ]; then
                git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR"
                ASDF_NEW=true
            fi
            cd "$ASDF_DIR"
            if [ $ASDF_NEW ]; then
                git checkout "$(git describe --abbrev=0 --tags)"
            else
                asdf update
            fi
        ) && \. "$ASDF_DIR/asdf.sh" && ([ -z "$BASH_VERSION" ] || \. "$ASDF_DIR/completions/asdf.bash")
    fi

    printf -- "%sInstalling/updating ASDF plugins...%s\n" "$BLUE" "$RESET"
    asdf plugin add golang
    asdf plugin add nodejs
    asdf plugin add php
    asdf plugin add python
    asdf plugin add ruby
    asdf plugin update --all

    printf -- "%sImporting PGP keyrings for ASDF plugins...%s\n" "$BLUE" "$RESET"
    "$HOME"/.asdf/plugins/nodejs/bin/import-release-team-keyring

    asdf install golang latest
    asdf install nodejs latest

    # Install NVM
    printf -- "%sInstalling/updating Node Version Manager...%s\n" "$BLUE" "$RESET"
    export NVM_DIR="$HOME/.nvm" && (
        NVM_NEW=false
        if [ ! -d "$NVM_DIR" ]; then
            git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
            NVM_NEW=true
        fi
        cd "$NVM_DIR"
        if [ ! $NVM_NEW ]; then
            git fetch --tags origin
        fi
        HASH=$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")
        git checkout "$HASH"
    ) && \. "$NVM_DIR/nvm.sh" && \. "$NVM_DIR/bash_completion"

    # Install Node.js
    printf -- "%sInstalling/updating Node.js...%s\n" "$BLUE" "$RESET"
    nvm install node
}

emit_dd_event() {
    # Emit a Datadog event for observability. No-ops silently if DD_API_KEY
    # is unset or curl is missing, so this is safe to call from any host.
    [ "${DOTFILES_DD_EVENTS:-1}" = "1" ] || return 0
    [ -n "${DD_API_KEY:-}" ] || return 0
    command_exists curl || return 0

    title=$1
    text=$2
    alert_type=${3:-info}
    dd_site="${DD_SITE:-datadoghq.com}"
    host_tag="host:$(hostname -s)"
    payload=$(printf '{"title":"%s","text":"%s","alert_type":"%s","tags":["source:dotfiles","%s"]}' \
        "$title" "$text" "$alert_type" "$host_tag")
    curl -s -o /dev/null \
        -X POST "https://api.${dd_site}/api/v1/events" \
        -H "Content-Type: application/json" \
        -H "DD-API-KEY: ${DD_API_KEY}" \
        -d "$payload" || true
}

setup_onepassword() {
    [ "${DOTFILES_SKIP_ONEPASSWORD:-0}" = "1" ] && return 0

    printf -- "\n%sSetting up 1Password:%s\n\n" "$BOLD" "$RESET"

    if ! command_exists op; then
        if [ "$(uname)" = "Linux" ]; then
            # Install the 1Password CLI from the official apt repo when Homebrew
            # isn't used on Linux. Non-fatal: if this fails CI/dev can still
            # proceed with DOTFILES_SKIP_ONEPASSWORD=1.
            if command_exists apt-get; then
                curl -sS https://downloads.1password.com/linux/keys/1password.asc \
                    | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg 2>/dev/null || true
                echo "deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main" \
                    | sudo tee /etc/apt/sources.list.d/1password.list >/dev/null
                sudo apt-get update -qq && sudo apt-get install -y 1password-cli || true
            fi
        fi
    fi

    if command_exists op; then
        # Surface a helpful reminder but don't block bootstrap on interactive sign-in.
        if [ -z "${OP_SERVICE_ACCOUNT_TOKEN:-}" ] && ! op whoami >/dev/null 2>&1; then
            printf -- "%sNote: run \`op signin\` to enable secret lookups.%s\n" "$BLUE" "$RESET"
        fi
    else
        printf -- "%sNote: 1Password CLI not installed; skipping.%s\n" "$BLUE" "$RESET"
    fi
}

setup_storage_mount() {
    [ "${DOTFILES_SKIP_STORAGE:-0}" = "1" ] && return 0

    printf -- "\n%sSetting up shared Development mount:%s\n\n" "$BOLD" "$RESET"

    command_exists rclone || {
        printf -- "%sNote: rclone not installed; skipping storage mount.%s\n" "$BLUE" "$RESET"
        return 0
    }

    DEV_DIR="${DOTFILES_DEV_DIR:-$HOME/Development}"
    mkdir -p "$DEV_DIR"

    # The rclone.conf is rendered by chezmoi at apply time. If it's absent
    # (e.g. no 1Password auth available) we bail out cleanly.
    if [ ! -f "$HOME/.config/rclone/rclone.conf" ]; then
        printf -- "%sNote: ~/.config/rclone/rclone.conf missing; skipping mount.%s\n" "$BLUE" "$RESET"
        return 0
    fi

    remote="${DOTFILES_DEV_REMOTE:-wasabi-dev}"
    if mount | grep -q "$DEV_DIR"; then
        printf -- "%s%s already mounted.%s\n" "$BLUE" "$DEV_DIR" "$RESET"
    else
        printf -- "%sMounting %s:%s via rclone...%s\n" "$BLUE" "$remote" "$DEV_DIR" "$RESET"
        rclone mount "${remote}:" "$DEV_DIR" \
            --daemon \
            --vfs-cache-mode writes \
            --log-file "$HOME/.cache/rclone-dev.log" \
            --log-level INFO || {
                error "rclone mount failed"
                emit_dd_event "dotfiles.storage.mount_failed" "rclone mount $remote -> $DEV_DIR failed" "error"
                return 1
            }
        # Wait up to 15s for the mount to appear.
        i=0
        while [ $i -lt 15 ]; do
            if mount | grep -q "$DEV_DIR"; then
                break
            fi
            sleep 1
            i=$((i + 1))
        done
    fi

    if mount | grep -q "$DEV_DIR"; then
        emit_dd_event "dotfiles.storage.mounted" "$DEV_DIR mounted via $remote" "info"
    else
        error "Mount verification failed for $DEV_DIR"
        emit_dd_event "dotfiles.storage.mount_failed" "Mount verification failed for $DEV_DIR" "error"
        return 1
    fi
}

setup_backups() {
    [ "${DOTFILES_SKIP_BACKUPS:-0}" = "1" ] && return 0

    # Restic-to-Wasabi backup is macOS-only in this repo.
    [ "$(uname)" = "Darwin" ] || return 0

    printf -- "\n%sSetting up restic backups:%s\n\n" "$BOLD" "$RESET"

    command_exists restic || {
        printf -- "%sNote: restic not installed; skipping backups.%s\n" "$BLUE" "$RESET"
        return 0
    }

    plist="$HOME/Library/LaunchAgents/com.user.restic-backup.plist"
    if [ -f "$plist" ]; then
        launchctl unload "$plist" 2>/dev/null || true
        launchctl load "$plist" 2>/dev/null || true
        emit_dd_event "dotfiles.backups.loaded" "restic LaunchAgent loaded" "info"
    else
        printf -- "%sNote: %s not present; skipping launchctl load.%s\n" "$BLUE" "$plist" "$RESET"
    fi
}

setup_monitoring() {
    [ "${DOTFILES_SKIP_MONITORING:-0}" = "1" ] && return 0

    printf -- "\n%sSetting up Datadog monitoring:%s\n\n" "$BOLD" "$RESET"

    if [ -z "${DD_API_KEY:-}" ]; then
        printf -- "%sNote: DD_API_KEY unset; skipping agent install.%s\n" "$BLUE" "$RESET"
        return 0
    fi

    os=$(uname)
    if [ "$os" = "Linux" ]; then
        if [ ! -d /etc/datadog-agent ]; then
            printf -- "%sInstalling Datadog Agent (Linux)...%s\n" "$BLUE" "$RESET"
            DD_API_KEY="$DD_API_KEY" \
            DD_SITE="${DD_SITE:-datadoghq.com}" \
            DD_APM_INSTRUMENTATION_ENABLED=host \
                bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)" || {
                    error "Datadog Agent install failed"
                    return 1
                }
        fi
    elif [ "$os" = "Darwin" ]; then
        if [ ! -d /opt/datadog-agent ] && ! command_exists datadog-agent; then
            printf -- "%sInstalling Datadog Agent (macOS)...%s\n" "$BLUE" "$RESET"
            DD_API_KEY="$DD_API_KEY" \
            DD_SITE="${DD_SITE:-datadoghq.com}" \
                bash -c "$(curl -L https://install.datadoghq.com/scripts/install_mac_os.sh)" || {
                    error "Datadog Agent install failed"
                    return 1
                }
        fi
    fi

    # datadog-ci for CI Pipeline + Test Visibility (installed globally via npm
    # when Node is available). Safe to re-run.
    if command_exists npm && ! command_exists datadog-ci; then
        npm install -g @datadog/datadog-ci || true
    fi

    emit_dd_event "dotfiles.monitoring.ready" "Datadog agent + datadog-ci ready on $(hostname -s)" "info"
}

finalize_dotfiles() {
    printf -- "\n%sFinalizing dotfiles:%s\n\n" "$BOLD" "$RESET"

    printf -- "%sUpdating dotfiles at destination...%s\n" "$BLUE" "$RESET"
    chezmoi apply
}

main() {
    printf -- "\n%sDotfiles setup script%s\n" "$BOLD" "$RESET"

    command_exists chezmoi || {
        error "chezmoi is not installed"
        exit 1
    }

    setup_color
    setup_dependencies
    setup_onepassword
    setup_prompts
    setup_applications
    setup_devtools
    setup_storage_mount
    setup_backups
    setup_monitoring
    finalize_dotfiles

    emit_dd_event "dotfiles.bootstrap.complete" "Bootstrap finished on $(hostname -s)" "success"

    printf -- "\n%sDone.%s\n\n" "$GREEN" "$RESET"

    # if [ -n "`$SHELL -c 'echo $ZSH_VERSION'`" ]; then
    #    [ -s "$HOME/.zshrc" ] && \. "$HOME/.zshrc"
    # elif [ -n "`$SHELL -c 'echo $BASH_VERSION'`" ]; then
    #    [ -s "$HOME/.bashrc" ] && \. "$HOME/.bashrc"
    # fi
}

main "$@"
