# Read things aloud faster
alias say="say --voice=Daniel --rate=275"

# Quick commands
alias c='clear'
alias x='exit'

# Find external IP address
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

# ls priority: exa, then gls, then ls
if [[ -n $(command -v exa) ]]; then
    alias ls="command exa -l --group-directories-first --git"
    alias la="command exa -la --group-directories-first --git"
else
    alias ls="command ls -la"
    alias ls="command ls -la"
fi

# Alias ag -> rg if ripgrep installed
if [[ -n $(command -v rg) ]]; then
    alias ag="rg"
    alias rg="rg --max-columns=1000 --smart-case"
fi

# vim:syntax=zsh
