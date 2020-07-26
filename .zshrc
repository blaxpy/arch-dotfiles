# https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template
export ZSH="${HOME}/.oh-my-zsh"
DISABLE_UPDATE_PROMPT="true"
HIST_STAMPS="yyyy-mm-dd"

# Powerline
# https://github.com/Powerlevel9k/powerlevel9k/wiki/Stylizing-Your-Prompt
# Show all colors in a terminal:
# for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="230"  # white
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="220"  # gold
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="230"  # white
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="031"  # blue

POWERLEVEL9K_VCS_CLEAN_FOREGROUND="230"  # white
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="022"  # green
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="230"  # white
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="166"  # orange
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="230"  # white
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="124"  # red

POWERLEVEL9K_DIR_HOME_FOREGROUND="230"  # white
POWERLEVEL9K_DIR_HOME_BACKGROUND="240"  # gray
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="230"  # white
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="240"  # gray
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="230"  # white
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="240"  # gray
POWERLEVEL9K_DIR_ETC_FOREGROUND="230"  # white
POWERLEVEL9K_DIR_ETC_BACKGROUND="240"  # gray

POWERLEVEL9K_VIRTUALENV_FOREGROUND="230"  # white
POWERLEVEL9K_VIRTUALENV_BACKGROUND="161"  # magneta

POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="230"  # white
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="105"  # purple

POWERLEVEL9K_TIME_FOREGROUND="230"  # white
POWERLEVEL9K_TIME_BACKGROUND="240"  # gray

# https://github.com/Powerlevel9k/powerlevel9k/blob/master/README.md#available-prompt-segments
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context vcs dir_writable dir virtualenv background_jobs status newline
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

