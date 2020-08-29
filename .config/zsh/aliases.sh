# 'alias-finder' oh-my-zsh plugin
alias af='alias-finder'
alias afe='alias-finder --exact'
alias afl='alias-finder --longer'

# Editor
alias vi=nvim
alias vim=nvim

# Thefuck
# https://github.com/nvbn/thefuck
eval "$(thefuck --alias f)"

# Send notification
# Usage:
#   sleep 1; alert "Notification message"
alias alert='notify-send --urgency=low -i terminal Finished'

# fd
# Unalias aliases from 'common-aliases' oh-my-zsh plugin
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
unalias fd
unalias ff
