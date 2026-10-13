# Bash completion
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
elif [[ -r /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

# Starship
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Direnv
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi

# Environment
export EDITOR="nvim"
export DOCKER_HOST="unix://${XDG_RUNTIME_DIR}/docker.sock"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PATH="$HOME/opt/openEMS/bin:$HOME/.local/bin:$PATH"

# Aliases
alias ls='eza --color=auto --icons --group-directories-first'
alias ll='eza -lh --color=auto --icons --group-directories-first'
alias la='eza -lah --color=auto --icons --group-directories-first'
alias grep='grep --color=auto'
alias tree='eza --tree'
alias vim='nvim'
alias neofetch='fastfetch'
alias cat='batcat --style=plain --paging=never'
alias df='duf'
alias less='batcat --style=plain --paging=auto'

# Wake-on-LAN through the router; the MAC comes from its static DHCP lease named "*desktop*"
wake-desktop() {
  ssh router sh -s <<'EOF'
host=$(uci show dhcp | sed -n "s/^dhcp\.\(.*\)\.name='.*desktop.*'$/\1/p" | head -1)
mac=$(uci -q get "dhcp.$host.mac")
[ -n "$mac" ] || { echo "No static lease named *desktop* on the router" >&2; exit 1; }
etherwake -i br-lan "$mac" && echo "Magic packet sent to $mac"
EOF
}

# opencode
export PATH=$HOME/.opencode/bin:$PATH

alias claude2='CLAUDE_CONFIG_DIR=~/.claude-second claude'
