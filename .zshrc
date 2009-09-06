#
# aliases
#

if ls --color=auto >&/dev/null; then
  # linux
  alias ls='ls --color=auto'
elif ls -G >&/dev/null; then
  # mac
  export CLICOLOR=1
  export LSCOLORS=ExFxCxDxBxegedabagacad
  alias ls='ls -G'
else
  alias ls='ls'
fi
alias l='ls -lhF'
alias la='ls -alhF'
# alias tree="find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
function tree() {
  find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

#
# completion
#

# zstyle ':completion:*' menu select=0

# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# zstyle ':completion:*:processes' command 'ps -U $(whoami) | sed "/ps/d"'
# zstyle ':completion:*:processes' insert-ids menu yes select
# zstyle ':completion:*:kill:*' insert-ids single
# zstyle ':completion:*:*:kill:*' menu yes select
# zstyle ':completion:*:kill:*' force-list always
# zstyle ':completion:*:processes-names' command  'ps c -u ${USER} -o command | uniq'

# case insensitive completion
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' matcher-list 'm:{a-z-}={A-Z_}'     'r:|[-_./]=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# zstyle :compinstall filename '/home/jzinn/.zshrc'

zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"

zstyle ':completion:*:rm:*' ignore-line yes

# zstyle ':completion:*:sudo:*' command-path /opt/local/bin /opt/local/sbin \
#     /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

autoload -Uz compinit && compinit
if [[ -e ~/.ssh/known_hosts ]]; then
  # Use .ssh/known_hosts for hostnames.
  hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
  zstyle ':completion:*:hosts' hosts $hosts
fi
setopt list_packed

# compdef _hosts initssh

#
# history
#

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt inc_append_history

# setopt share_history

#
# keybindings
#

bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

typeset -g -A key

# autoload zkbd
# [[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && zkbd
# source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE

bindkeys() {
  [[ -n "${key[Backspace]}" ]] && bindkey "${key[Backspace]}" backward-delete-char
  [[ -n "${key[Insert]}"    ]] && bindkey "${key[Insert]}"    overwrite-mode
  [[ -n "${key[Delete]}"    ]] && bindkey "${key[Delete]}"    delete-char
  [[ -n "${key[Home]}"      ]] && bindkey "${key[Home]}"      beginning-of-line
  [[ -n "${key[End]}"       ]] && bindkey "${key[End]}"       end-of-line
#  [[ -n "${key[Up]}"        ]] && bindkey "${key[Up]}"        up-line-or-history
#  [[ -n "${key[Down]}"      ]] && bindkey "${key[Down]}"      down-line-or-history
#  [[ -n "${key[Up]}"        ]] && bindkey "${key[Up]}"        history-beginning-search-backward
#  [[ -n "${key[Down]}"      ]] && bindkey "${key[Down]}"      history-beginning-search-forward
  [[ -n "${key[Up]}"        ]] && bindkey "${key[Up]}"        history-beginning-search-backward-end
  [[ -n "${key[Down]}"      ]] && bindkey "${key[Down]}"      history-beginning-search-forward-end
  [[ -n "${key[Right]}"     ]] && bindkey "${key[Right]}"     forward-char
  [[ -n "${key[Left]}"      ]] && bindkey "${key[Left]}"      backward-char
}

# putty
key[Backspace]='^?'
key[Insert]='^[[2~'
key[Delete]='^[[3~'
key[Home]='^[[1~'
key[End]='^[[4~'
key[PageUp]='^[[5~'
key[PageDown]='^[[6~'
key[Up]='^[[A'
key[Down]='^[[B'
key[Right]='^[[C'
key[Left]='^[[D'

bindkeys

# linux
key[Backspace]='^?'
key[Insert]='^[[2~'
key[Delete]='^[[3~'
key[Home]='^[OH'
key[End]='^[OF'
key[PageUp]='^[[5~'
key[PageDown]='^[[6~'
key[Up]='^[OA'
key[Down]='^[OB'
key[Right]='^[OC'
key[Left]='^[OD'

bindkeys

bindkey '^[[1;5C' forward-word  # ctrl-right
bindkey '^[[1;5D' backward-word # ctrl-left

# mac
key[Backspace]='^?'
#key[Insert]=''
key[Delete]='^[[3~'
key[Home]='^[[H'
key[End]='^[[F'
key[PageUp]='^[[5~'
key[PageDown]='^[[6~'
key[Up]='^[[A'
key[Down]='^[[B'
key[Right]='^[[C'
key[Left]='^[[D'

bindkeys

bindkey '^[[5C' forward-word  # ctrl-right
bindkey '^[[5D' backward-word # ctrl-left

#
# options
#

setopt nobeep
setopt NO_bg_nice
setopt correct
setopt extendedglob
setopt NO_flowcontrol
setopt print_exit_value
setopt rm_star_silent

#
# parameters used by the shell
#

typeset -U manpath
[[ -d ~/man ]] && manpath=(~/man $manpath)
[[ -d /usr/local/git/bin ]] && manpath=(/usr/local/git/bin $manpath)

typeset -U path
[[ -d ~/bin ]] && path=(~/bin $path)
[[ -d /usr/local/git/man ]] && path=(/usr/local/git/man $path)

watch=(notme)

#
# prompt
#

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "(${ref#refs/heads/})"
}
autoload -U colors && colors
setopt prompt_subst
prompt='
%(!.%{$fg[red]%}.%{$fg[green]%})%n%{$fg[green]%}@%m:%{$fg[yellow]%}%~%{$reset_color%}$(git_prompt_info)
%(!.%{$fg[red]%}#%{$reset_color%}.$) '

#
# _why title
#

# format titles for screen and rxvt
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\"      # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2 | $a:$3\a" # plain xterm title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "$USER@%m" "%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}

return 0
