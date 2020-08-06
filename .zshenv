# https://wiki.archlinux.org/index.php/XDG_Base_Directory
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
XDG_DATA_HOME=$HOME/.local/share
XDG_DATA_DIRS=/usr/local/share:/usr/share
XDG_CONFIG_DIRS=/etc/xdg

# CONFIG
ZDOTDIR=$XDG_CONFIG_HOME/zsh
IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

# FZF
# https://github.com/junegunn/fzf
FZF_DEFAULT_OPTS="--layout=reverse --height 20%"

# VirtualenvWrapper
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/virtualenvwrapper
# https://virtualenvwrapper.readthedocs.io/en/latest/install.html#shell-startup-file
WORKON_HOME=$HOME/.virtualenvs
PROJECT_HOME=$HOME/PycharmProjects
