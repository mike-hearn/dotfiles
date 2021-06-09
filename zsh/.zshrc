unset ENV

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

export LESS="-R --quit-if-one-screen"
export SHELL=/bin/zsh
export ZSH_CUSTOM="$HOME/.config/shell/zsh"


# Base extensions + oh-my-zsh
zinit wait lucid light-mode for \
  atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions \
  atinit"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions \
  softmoth/zsh-vim-mode \
  OMZ::plugins/docker/_docker \
  OMZP::colored-man-pages \
  OMZP::django \
  OMZP::docker-compose \
  OMZP::git \
  OMZP::npm \
  OMZP::ssh-agent \
  OMZP::yarn \
  OMZL::history.zsh \
  atload"enable-fzf-tab" Aloxaf/fzf-tab \

zinit lucid light-mode for \
  OMZL::history.zsh \


# Install required binaries
zinit from"gh-r" as"program" \
  atclone'./starship init zsh > zhook.zsh' atpull'%atclone' \
  pick"starship" src="zhook.zsh" for \
  starship/starship

zinit from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
    pick"direnv" src="zhook.zsh" for \
    direnv/direnv

zinit from"gh-r" as"program" mv"jump* -> jump" \
    atclone'./jump shell zsh > zhook.zsh' atpull'%atclone' \
    pick"jump" src="zhook.zsh" for \
    gsamokovarov/jump

zinit from"gh-r" as"program" mv"bin/exa* -> exa" \
    pick"exa" for ogham/exa

zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

zinit wait lucid light-mode for \
  atload"enable-fzf-tab" Aloxaf/fzf-tab


# Function path
fpath+=(
  "$ZSH_CUSTOM/functions"
  "$HOME/.zfunctions"
  "$fpath"
)


# Autosource files
zinit snippet ~/.dotfiles/shell/.config/shell/shared/01_path.sh
for f in ~/.config/shell/shared/*
do
  zinit ice wait lucid
  zinit snippet $f
done
for f in ~/.config/shell/settings/*
do
  zinit ice wait lucid
  zinit snippet $f
done
for f in ~/.config/shell/zsh/autosource/*sh
do
  zinit ice wait lucid
  zinit snippet $f
done

