export PATH=$PATH:$HOME/.local/bin

export EDITOR=nvim

# Output ANSI "color" escape sequences in "raw" form.
LESS+=' --RAW-CONTROL-CHARS'
# Show the current position within the file on the prompt.
LESS+=' --LONG-PROMPT'
# Exit if an output fits the screen.
LESS+=' --quit-if-one-screen'
# Do not clear the screen after exiting.
# LESS+=' --no-init'
export LESS

export PAGER=less
# Run commands G (go to the end of the file) and g (go back to the beginning of the file)
# to properly calculate the position.
export MANPAGER='less +Gg'

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# Set configuration directories.
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx $XDG_CONFIG_HOME/X11/xinitrc
fi
