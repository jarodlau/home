#
# ~/.bashrc
#
export EDITOR="vim"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Some useful alias
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'

# Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
alias pacmir='sudo pacman -Syy'
alias pacup='sudo pacman -Syu'

alias pacin='sudo pacman -S'
alias pacout='sudo pacman -Rns'

# 
alias pacrep='pacman -Si'              
alias pacreps='pacman -Ss'             
alias pacloc='pacman -Qi'              
alias paclocs='pacman -Qs'             

#lets you search through all available packages simply using 'pacsearch packagename'
alias pacsearch="pacman -Sl | cut -d' ' -f2 | grep " 
# colorized pacman output with pacs alias:
alias pacs="pacsearch-color"
pacsearch-color () {
echo -e "$(pacman -Ss $@ | sed \
    -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
    -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
    -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
    -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

# color grep
export GREP_COLOR="1;33"
alias grep='grep --color=auto'

# color less
export LESS="-R"

##  colorful ps1

BLUE=`tput setf 1`
GREEN=`tput setf 2`
CYAN=`tput setf 3`
RED=`tput setf 4`
MAGENTA=`tput setf 5`
YELLOW=`tput setf 6`
WHITE=`tput setf 7`
PS1='\[$GREEN\]\u@\[$RED\]\h \[$BLUE\]\w\[$YELLOW\] \$\[$WHITE\] '
#PS1='[\u@\h \W]\$ '

export HISTCONTROL=ignoreboth

# color man

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;37m") \
		LESS_TERMCAP_md=$(printf "\e[1;37m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[0;36m") \
			man "$@"
}

