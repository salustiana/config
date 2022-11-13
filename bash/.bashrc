#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1="\[\e[1m\e[33m\]\w\[\e[0m\] "

alias gst='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'

# history
HISTIGNORE="ls:gst:gd"
HISTSIZE=50000
HISTFILESIZE=50000
