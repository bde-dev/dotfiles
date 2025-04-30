#
# ~/.bashrc
#

# ~~~~~~~~ Bash Profiling ~~~~~~~~~~

#PS4='+ $EPOCHREALTIME\011 '
#timestamp=$(date +"%Y%m%d_%H%M%S")
#exec 3>&2 2>/tmp/bashstart_${timestamp}_$$.log
#set -x

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# keybinds
bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim

# config
export BROWSER="google-chrome"

# directories
# common
export REPOS="$HOME/dev/repos"
export NEEDREPO="$REPOS/need-repo"
export GHREPOS="$REPOS/github.com"
export BBREPOS="$REPOS/bitbucket.org"

# personal
export PGITUSER="bde-dev"
export PGHREPOS="$REPOS/github.com/$PGITUSER"
export DOTFILES="$PGHREPOS/dotfiles"
export LAB="$PGHREPOS/homelab"
export SCRIPTS="$DOTFILES/scripts"
export BLOG="$PGHREPOS/bde-dev.github.io"
export ICLOUD="$HOME/icloud"
export ZETTELKASTEN="$HOME/Zettelkasten"

# tcs
export TCSGITUSER="bd-evans"
export TCSGHREPOS="$REPOS/github.com/$TCSGITUSER"
export TCSBBREPOS="$REPOS/bitbucket.org/$TCSGITUSER"
export Q2="$TCSBBREPOS/qorex2"
export TCSCOMMS="$TCSBBREPOS/TCS.Comms"
export DDSR="$TCSGHREPOS/WinningNumberDisplay"
export DDSB="$TCSBBREPOS/dds-baccarat"
export RLX="$TCSGHREPOS/RouletteXtra"
export TORBS="$TCSBBREPOS/tcsjh-circleci-orbs"

# Go related. In general all executables and scripts go in .local/bin
export GOBIN="$HOME/.local/bin"
export GOPRIVATE="github.com/$PGITUSER/*,gitlab.com/$PGITUSER/*"
# export GOPATH="$HOME/.local/share/go"
export GOPATH="$HOME/go/"

# dotnet
export DOTNET_ROOT="$HOME/dotnet"

# Godot
export GODOT_PATH=~/Downloads/Godot_v4.3-stable_mono_linux_x86_64/Godot_v4.3-stable_mono_linux.x86_64

# get rid of mail notifications on MacOS
unset MAILCHECK

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

PATH="${PATH:+${PATH}:}"$SCRIPTS":"$HOME"/.local/bin:$HOME/dotnet" # appending

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# This function is stolen from rwxrob

clone() {
  local repo="$1" user
  echo "captured repo: $repo"
  local repo="${repo#https://github.com/}"
  echo "repo: $repo"
  local repo="${repo#git@github.com:}"
  echo "repo: $repo"
  if [[ $repo =~ / ]]; then
    user="${repo%%/*}"
  else
    user="$PGITUSER"
    [[ -z "$user" ]] && user="$USER"
  fi
  echo "user: $user"
  local name="${repo##*/}"
  echo "name: $name"
  local userd="$REPOS/github.com/$user"
  echo "userd: $userd"
  local path="$userd/$name"
  echo "path: $path"
  [[ -d "$path" ]] && cd "$path" && return
  mkdir -p "$userd"
  cd "$userd"
  echo gh repo clone "$user/$name" -- --recurse-submodule
  gh repo clone "$user/$name" -- --recurse-submodule
  cd "$name"
} && export -f clone

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Only run on Ubuntu

if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
  eval "$(ssh-agent -s)" >/dev/null
  eval "$(fzf --bash)"
fi

# adding keys was buggy, add them outside of the script for now
# ssh-add -q ~/.ssh/mischa
# ssh-add -q ~/.ssh/mburg
#{
#ssh-add -q ~/.ssh/id_ed25519
#ssh-add -q ~/.ssh/vanoord
#ssh-add -q ~/.ssh/delegate
#} &>/dev/null

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~

# Moved to starship 20-03-2024 for all my prompt needs.

eval "$(starship init bash)"

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
# alias vim=nvim

# cd
alias vo='cd $REPOS/github.com/VanOord/'
alias ..="cd .."
alias scripts='cd $SCRIPTS'
alias cdblog='cd $BLOG'
alias cdpblog='cd $ZETTELKASTEN/2-areas/blog/content'
alias testblog='cd $BLOG && hugo server'

# ssh
alias sshc='v $HOME/.ssh/config'

# Repos
# common
alias repos='cd $REPOS'
alias needrepo='cd $NEEDREPO'
alias ghrepos='cd $GHREPOS'
alias bbrepos='cd $BBREPOS'

# personal
alias lab='cd $LAB'
alias cks='cd $LAB/kubernetes/cks/'
alias alab='cd $GHREPOS/azure-lab'
alias dot='cd $PGHREPOS/dotfiles'
alias pgh='cd $PGHREPOS'
alias cdgo='cd $GHREPOS/go/'
alias ex='cd $REPOS/github.com/$PGITUSER/go/Exercism/'
alias rwdot='cd $REPOS/github.com/rwxrob/dot'

alias avm='cd $REPOS/github.com/Azure/bicep-registry-modules'
alias d='cd $REPOS/delegate'

# tcs
alias tgh='cd $TCSGHREPOS'
alias tbb='cd $TCSBBREPOS'
alias q2='cd $Q2'
alias q2d='cd $Q2/Docker'
alias tcscomms='cd $TCSCOMMS'
alias ddsr='cd $DDSR'
alias ddsb='cd $DDSB'
alias rlx='cd $RLX'
alias torbs='cd $TORBS'

alias c="clear"
alias icloud="cd \$ICLOUD"
alias rob='cd $REPOS/github.com/rwxrob'
alias homelab='cd $REPOS/github.com/$PGITUSER/homelab/'
alias hl='homelab'
alias hlp='cd $REPOS/github.com/$PGITUSER/homelab-private/'
alias hlps='cd $REPOS/github.com/$PGITUSER/homelab-private-staging/'
alias hlpp='cd $REPOS/github.com/$PGITUSER/homelab-private-production/'
alias cdq='cd $REPOS/github.com/jackyzha0/quartz'

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
# alias la='exa -laghm@ --all --icons --git --color=always'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# Azure

alias sub='az account set -s'

# dotnet
alias dr='dotnet run'

# bash parameter completion for the dotnet CLI

function _dotnet_bash_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n' # On Windows you may need to use use IFS=$'\r\n'
  local candidates

  read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)

  read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}

complete -f -F _dotnet_bash_complete dotnet

# Godot
alias godot='$GODOT_PATH'

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# ricing
alias et='v ~/.config/awesome/themes/powerarrow/theme-personal.lua'
alias ett='v ~/.config/awesome/themes/powerarrow-dark/theme-personal.lua'
alias er='v ~/.config/awesome/rc.lua'
alias eb='v ~/.bashrc'
alias ev='cd ~/.config/nvim/ && v init.lua'
alias sbr='source ~/.bashrc'
alias s='startx'

# vim & second brain
alias in="cd \$ZETTELKASTEN/05-inbox/"
alias zk="cd \$ZETTELKASTEN"

# starting programmes
alias cards='python3 /opt/homebrew/lib/python3.11/site-packages/mtg_proxy_printer/'

# terraform
alias tf='terraform'
alias tp='terraform plan'

# fun
alias fishies=asciiquarium

# Docker
alias dcu='docker compose up -d'
alias dcd='docker compose down'

# kubectl
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'
alias kcs='kubectl config use-context admin@homelab-staging'
alias kcp='kubectl config use-context admin@homelab-production'

# flux
source <(flux completion bash)
alias fgk='flux get kustomizations'

# completions
source <(talosctl completion bash)
source <(kubectl-cnp completion bash)
source <(cilium completion bash)
#source <(devpod completion bash)

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

# sourcing
if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$HOME/.fzf.bash"
  # echo "I'm on Mac!"

  # brew bash completion
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
  #	source /usr/share/fzf/key-bindings.bash
  #	source /usr/share/fzf/completion.bash

  # The first one worked on Ubuntu, the eval one on Fedora. Keeping for reference.
  # [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  eval "$(fzf --bash)"
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/brad/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# ~~~~~~~~ Profiling ~~~~~~~~~

#set +x
#exec 2>&3 3>&-
#
#
#START_TIME=$EPOCHREALTIME
#END_TIME=$EPOCHREALTIME
#ELAPSED_MS=$(printf "%.0f" $(echo "($END_TIME - $START_TIME) * 1000" | bc))
#
#
#echo "Bash startup took $ELAPSED_MS ms"
