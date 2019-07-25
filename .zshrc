# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Powerline
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_first_and_last"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

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

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

HIST_STAMPS="yyyy-mm-dd"

# FZF
export FZF_BASE=~/.fzf
export FZF_DEFAULT_OPTS="--layout=reverse --height 20%"

# Virtualenvwrapper
export WORKON_HOME="${HOME}/.virtualenvs"
export PROJECT_HOME="${HOME}/PycharmProjects"
# DISABLE_VENV_CD=1

plugins=(
    common-aliases
    alias-finder

    vi-mode

    fzf
    fd
    ripgrep

    git

    pip
    virtualenvwrapper

    docker
    docker-compose

    ansible

    kubectl
    helm

    tmux
)

source "${ZSH}/oh-my-zsh.sh"

# Vi-mode
# Overrides `zle-keymap-select` function from 'vi-mode' oh-my-zsh plugin.
function zle-keymap-select() {
    # Runs when keymap changes.

    # Update a keymap variable for a prompt.
    VI_KEYMAP="${KEYMAP}"

    if [[ "${KEYMAP}" == "vicmd" ]]; then
        # Use a block cursor in 'normal' vi mode.
        # For a blinking block cursor use '1'.
        print -n '\e[2 q'
    else
        # Use a beam cursor in 'insert' vi mode.
        # For a blinking beam cursor use '5'.
        print -n '\e[6 q'
    fi

    zle reset-prompt
    zle -R
}

function zle-line-init() {
    # Changes to 'insert' vi mode.
    zle -K viins
}

# Start every prompt in 'insert' vi mode.
zle -N zle-line-init

function _vi_mode_reset_cursor() {
    # Changes a cursor to a block cursor.
    print -n '\e[2 q'
}

autoload -U add-zsh-hook
# Reset a cursor before running an application.
add-zsh-hook preexec _vi_mode_reset_cursor

# Make vi mode transitions faster (1 = 10ms).
export KEYTIMEOUT=1

# Manually read '.profile' when connecting with ssh.
if [[ -n "${SSH_CLIENT}" ]] || [[ -n "${SSH_CONNECTION}" ]] || [[ -n "${SSH_TTY}" ]]; then
    . "${HOME}/.profile"
fi

if [[ -f "${HOME}/.aliases" ]]; then
    . "${HOME}/.aliases"
fi

# Thefuck
eval "$(thefuck --alias f)"
# export THEFUCK_REQUIRE_CONFIRMATION="false"

# Autosuggestions
source "${HOME}/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Syntax highlighting
# `source` command must be at the end of the file!
source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
