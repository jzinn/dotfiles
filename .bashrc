# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ]; then
    PATH=${HOME}/bin:${PATH}
fi
if [ -d "/usr/local/git/bin" ]; then
    PATH=/usr/local/git/bin:${PATH}
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
    MANPATH=${HOME}/man:${MANPATH}
fi
if [ -d "/usr/local/git/man" ]; then
    MANPATH=/usr/local/git/man:${MANPATH}
fi

PATH=${PATH}:/usr/local/mysql/bin

#if [ -d "/opt/local/bin" ]; then
#	PATH=${PATH}:/opt/local/bin:/opt/local/sbin
#	MANPATH=${MANPATH}:/opt/local/share/man
#fi

# from sully
# keychain id_rsa 
# . ~/.keychain/$HOSTNAME-sh

export ENSCRIPT="--tabsize=4 --mark-wrapped-lines=arrow --word-wrap -C -M Letter -E -Gr2"
export FTP_PASSIVE=1
export SYBASE=/usr/local/freetds
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/freetds/lib
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\H:\[\e[33m\]\w\[\e[0m\]\n\$ ' 
export PAGER='less -SinFX'
export MYSQL_PS1="`hostname | sed 's/\..*//'`:\\d> "
# export MYSQL_PS1="`hostname | sed 's/\..*//'` -> \\h:\\d\\n> "
# export MYSQL_PS1="\\d@$HOSTNAME> "
export CLICOLOR=1

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi 
complete -o dirnames cd

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoreboth"

# Ignore some controlling instructions
export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"

alias df='df -h'
alias du='du -h'

alias l='ls -lhF'
alias la='l -a'
alias less='less -SinFX'

function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }
