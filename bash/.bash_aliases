alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ll='ls -alF --color=auto'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# WARNING: option 'always' uses color escape codes, even when in a pipe!
alias zgrep='zgrep --color=always'

# ssh without touching known_hosts or sending keys
alias tempssh='ssh -o UserKnownHostsFile=/dev/null -o PubkeyAuthentication=no -o VisualHostKey=yes'
alias tempsftp='sftp -o UserKnownHostsFile=/dev/null -o PubkeyAuthentication=no'

# run application in vpn network namespace
alias vpnexec='sudo ip netns exec vpn sudo -u $(whoami)'
# allow command completion (-c)
if [ -n "$BASH_VERSION" ]; then
    complete -c vpnexec
fi

# ring terminal bell
alias bell='tput bel'

# function to calculate CRC32 and ring bell upon completion
crc32() {
    rhash -C --percents --speed --simple --uppercase -r "$@" && tput bel
}

# open file in existing gvim
alias gvim='gvim --remote-tab-silent'

# cdf - cd into the directory of the selected file using fzf
cdf() {
    local file
    local dir
    file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

alias phd='cd ~/gdrive/Studium/PhD'

# debian renames bat to batcat, undo it
if command -v batcat >/dev/null 2>&1; then
    alias bat='batcat'
fi
