export TERM=screen
export PS1="> "
cd $HOME

function _send {
    echo "$NODEKEYS" | while read line || [[ -n $line ]];
    do
        if [[ "$line" != "" && "$line" != '#'*  ]]; then
            tmux send-keys -t "$line". "$@" Enter
        fi
    done
}

function __push_enter {
    if [ "$BUFFER" != "" ]; then        
        print -S "$BUFFER"

        echo "\nsend command:\n  $BUFFER"
        _send "$BUFFER"
        BUFFER=""
    fi
    zle accept-line
}

zle -N __push_enter
bindkey '^M' __push_enter

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt sharehistory
setopt appendhistory
