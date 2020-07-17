# This file is executed by the command interpreter for login shells.

# Set PATH so it includes user's private bin if it exists.
if [ -d "${HOME}/bin" ]; then
    PATH="${HOME}/bin:${PATH}"
fi

export LANG=en_US.UTF-8
export EDITOR=nvim

# Cache directory is on tmpfs. To save selected databases between restarts,
# keepassxc cache directory is stored in home directory.
ln --symbolic "${HOME}/keepassxc" "${HOME}/.cache"
