# https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template
export ZSH="${HOME}/.oh-my-zsh"
DISABLE_UPDATE_PROMPT="true"
HIST_STAMPS="yyyy-mm-dd"

# Powerline
# https://github.com/Powerlevel9k/powerlevel9k/wiki/Stylizing-Your-Prompt
# Show all colors in a terminal:
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="black"
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="gold1"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="black"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="038"  # blue

POWERLEVEL9K_VCS_CLEAN_FOREGROUND="015"  # white
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="022"  # green
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="015"  # white
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="166"  # orange
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="015"  # white
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="124"  # red

POWERLEVEL9K_DIR_HOME_BACKGROUND="252"  # gray
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="252"  # gray
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="252"  # gray
POWERLEVEL9K_DIR_ETC_BACKGROUND="252"  # gray

POWERLEVEL9K_VIRTUALENV_BACKGROUND="violet"

POWERLEVEL9K_TIME_BACKGROUND="252"  # gray

# https://github.com/Powerlevel9k/powerlevel9k/blob/master/README.md#available-prompt-segments
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context vcs dir_writable dir virtualenv background_jobs status #vi_mode
    newline
    time
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# https://github.com/romkatv/powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# SSH-Agent
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding on

# FZF
# https://github.com/junegunn/fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 20%"

# VirtualenvWrapper
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/virtualenvwrapper
# https://virtualenvwrapper.readthedocs.io/en/latest/install.html#shell-startup-file
export WORKON_HOME="${HOME}/.virtualenvs"
export PROJECT_HOME="${HOME}/PycharmProjects"

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    # Editing
    vi-mode

    # Aliases
    alias-finder
    common-aliases
    extract

    # Distributions
    archlinux
    debian

    # Daemons
    ssh-agent
    gpg-agent

    # Tools
    rsync
    tmux
    ansible
    fzf
    fd
    ripgrep
    httpie

    # Development
    git
    gitignore
    pip
    virtualenvwrapper
    docker
    docker-compose
    kubectl
    helm

    # Misc
    colored-man-pages
)

source "${ZSH}/oh-my-zsh.sh"

# Vi-mode
if (( $+functions[zle-keymap-select] )); then
    function _change_cursor_shape_to_block () {
        # For a blinking block cursor use '1'.
        print -n '\e[2 q'
    }

    function _change_cursor_shape_to_beam () {
        # For a blinking beam cursor use '5'.
        print -n '\e[6 q'
    }

    # Always start a new shell with a beam cursor.
    if (( $+functions[zle-line-init] )); then
        # Override `zle-line-init` if it exists.
        eval "original-$(declare -f zle-line-init)"

        function zle-line-init () {
            _change_cursor_shape_to_beam
            original-zle-line-init
        }
    else
      function zle-line-init () {
        _change_cursor_shape_to_beam
      }
    fi

    zle -N zle-line-init

    # Change cursor shape on vi mode change.
    # Override `zle-keymap-select` from 'vi-mode' oh-my-zsh plugin.
    eval "original-$(declare -f zle-keymap-select)"

    function zle-keymap-select () {
        if [[ "${KEYMAP}" == "vicmd" ]]; then
            # Use a block cursor in 'normal' vi mode.
            _change_cursor_shape_to_block
        else
            # Use a beam cursor in 'insert' vi mode.
            _change_cursor_shape_to_beam
        fi
        original-zle-keymap-select
    }

    # Reset the cursor shape before running an application.
    autoload -U add-zsh-hook
    add-zsh-hook preexec _change_cursor_shape_to_block

    # 'insert' vi mode bindings
    # https://github.com/zsh-users/zsh/blob/master/Src/Zle/iwidgets.list
    bindkey '^U' backward-kill-line
    bindkey '^K' kill-line
    bindkey '^Y' yank
    # Insert the last word with Alt-Dot.
    bindkey '^[.' insert-last-word
    # Cycle backwards through suggestions with Shift-Tab.
    bindkey '^[[Z' reverse-menu-complete

    # Decrease vi mode change time (1 = 10ms).
    export KEYTIMEOUT=1
fi

# Git
# Prevent git from always using pager
unset LESS

# Docker
function docker-backup () {
    DIR=`pwd`
    docker run --rm -v $1:/volume -v $DIR:/backup alpine sh -c "cd /volume && tar -czf /backup/$1.tar.gz ."
    ls -lh $DIR/$1.tar.gz
}

function docker-restore () {
    DIR=`pwd`
    docker run --rm -v $1:/volume -v $DIR:/backup alpine sh -c "cd /volume && find . -maxdepth 1 -not -path . -exec rm -rf {} \; && tar -xf /backup/$1.tar.gz && ls -lah"
}

# Manually read '.profile' when connecting with ssh.
if [[ -n "${SSH_CLIENT}" ]] || [[ -n "${SSH_CONNECTION}" ]] || [[ -n "${SSH_TTY}" ]]; then
    . "${HOME}/.profile"
fi

if [[ -f "${HOME}/.aliases" ]]; then
    . "${HOME}/.aliases"
fi

# Autosuggestions
# source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
# https://github.com/zsh-users/zsh-autosuggestions/issues/363
# ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(backward-kill-word)

# Syntax highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting/issues/150
# `source` command must be at the end of the file!
# source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

