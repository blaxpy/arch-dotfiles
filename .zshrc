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

. "${ZSH}/oh-my-zsh.sh"

# Manually read '.profile' when connecting with ssh.
if [[ -n "${SSH_CLIENT}" ]] || [[ -n "${SSH_CONNECTION}" ]] || [[ -n "${SSH_TTY}" ]]; then
    . "${HOME}/.profile"
fi

if [[ -d "${HOME}/.zsh" ]]; then
    if [[ -f "${HOME}/.zsh/aliases.sh" ]]; then
        . "${HOME}/.zsh/aliases.sh"
    fi

    if [[ -f "${HOME}/.zsh/functions.sh" ]]; then
        . "${HOME}/.zsh/functions.sh"
    fi

    # Autosuggestions
    # https://github.com/zsh-users/zsh-autosuggestions/issues/363
    # if [[ -d "${HOME}/.zsh/zsh-autosuggestions" ]]; then
    #     . "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
    #     # ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(backward-kill-word)
    # fi

    # Syntax highlighting
    # https://github.com/zsh-users/zsh-syntax-highlighting/issues/150
    # Source command must be at the end of the file!
    # if [[ -d "${HOME}/.zsh/zsh-syntax-highlighting" ]]; then
    #     . "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    # fi
fi

