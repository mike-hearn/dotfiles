[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_CTRL_R_OPTS='--sort'
export FZF_CTRL_T_COMMAND='fd --hidden'
export FZF_DEFAULT_COMMAND='command rg --files'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
