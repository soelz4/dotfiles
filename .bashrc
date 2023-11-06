#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

clear

alias grep="grep --color=auto"

# colors
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
cyan=$(tput setaf 6)
whilte=$(tput setaf 7)
default=$(tput setaf 9)
reset=$(tput sgr0)

# prompt
PS1="\[$green\]\u\[$reset\]@\[$cyan\]\h \[$reset\]// \[$purple\]\w \[$reset\]>> \[$purple\]\\n$\[$reset\] "

# exa
alias ls="exa --long --all --icons --header"

# kitty icat
alias icat="kitten icat"

# neofetch
alias neofetch="neofetch --kitty"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# fish shell
# exec fish
