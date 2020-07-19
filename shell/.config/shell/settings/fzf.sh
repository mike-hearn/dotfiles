# FZF

case $SHELL in
    */zsh)
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
        ;;
    */bash)
        [ -f ~/.fzf.bash ] && source ~/.fzf.bash
        ;;
    *)
        [ -f ~/.fzf.bash ] && source ~/.fzf.bash
esac

export FZF_CTRL_R_OPTS='--sort'
export FZF_CTRL_T_COMMAND='fd --hidden --no-ignore'
export FZF_DEFAULT_COMMAND='sort -u <(fd) <(fd --hidden --no-ignore --max-depth 1 --type=f .env) <(git ls-files) <(git ls-files --others --exclude-standard)'
export FZF_COMPLETION_OPTS='--bind=tab:down,btab:up --cycle'

_fzf_compgen_path() {
    command rg --files --no-ignore --hidden --color=never \
        --glob \!"*node_modules*" \
        --glob \!"*tmp*" \
        --glob \!"*bower_components*" \
        --glob \!"*venv*" \
        --glob \!"*.git" \
        --glob \!"*.pyc" \
        "$1"
}


_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
