# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# SSH Agent
# https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login#18915067
# Conflicts with GNOME keyring.
# https://askubuntu.com/questions/3045/how-to-disable-gnome-keyring
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo "Successfully initialized new SSH agent"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep "${SSH_AGENT_PID}" | grep 'ssh-agent$' > /dev/null || start_agent
else
    start_agent
fi

export LANG=en_US.UTF-8
export EDITOR='nvim'
