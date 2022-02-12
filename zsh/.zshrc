# source profile files
if [ -f /etc/profile ]; then
    . /etc/profile
fi
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Set up the prompt
autoload -Uz promptinit
promptinit
# prompt suse

prompt_david_setup() {
    # set window title
    TITLE=$'%{\e]0;%n@%m: %~\a%}'
    PS1="${TITLE}%B%F{green}%n@%m:%f%F{blue}%~%f%b%# "
}
prompt_themes+=( david )
prompt david

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zmodload zsh/complist
# use shift-tab for reverse tabbing
bindkey -M menuselect "^[[Z" reverse-menu-complete

# behave more like bash
# -------------------
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

# make C-W and M-Backspace do the expected
backward-kill-dir() {
    local WORDCHARS=""
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

setopt histignorespace

# might only work on xterm-like terminals
bindkey "^[[1;5C" emacs-forward-word
bindkey "^[[1;5D" emacs-backward-word
# -------------------

# source bash aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable zsh-syntax-highlighting if availalble
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
