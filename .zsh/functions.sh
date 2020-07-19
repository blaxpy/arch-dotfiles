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

