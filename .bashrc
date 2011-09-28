# Thu 29 Sep 2011 05:38:30 AM CST
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

if [ -f $HOME/.alias ]; then
	source $HOME/.alias
fi

# [ export 环境变量 ]# {{{
#--------------------------------------------

export PATH=$PATH:${HOME}/code/shell:${HOME}/.todo
export CDPATH='.:..:../..:~:~/text:~/code:~/pic:~/yuer:~/public_html/'
export MYSQL_PS1="[\\u@\\h \\d]"
export EDITOR="vim"

# ibus config 
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# 重新编译ibus-sunpinyin解决问题
#setup XIM environment, need not if use SCIM as gtk-immodules
#export XMODIFIERS=@im=fcitx
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
# go-office gtk2 set
#export OOO_FORCE_DESKTOP=gnome
#export OOO_FORCE_DESKTOP=gnome

# xterm urxvt 256 color [tmux]
# 默认 debian
# 没有进入 screen TERM=xterm
# 进入 screen TERM=screen
#export TERM=xterm-256color

# XXX 不行 进入 screen 后，默认 TERM 为 screen，若进入 screen 则修改 TERM
#[[ $TERM == "screen" ]] && export TERM="xterm-256color"

# XXX 在 .Xdefaults 中设置：xterm*termName: xterm-256color
# 不用在 .bashrc / .zshrc 中同时设置 $TERM





# }}}

# [ Prompt PS1 提示符 ]#{{{
#--------------------------------------------

# debian 默认 PS1：ink@king:~$
# ${debian_chroot:+($debian_chroot)}\u@\h:\w\$
# XXX 可以在 screen 中标题显示为 相对路径
#\[\ek\e\\\]\[\ek\W\e\\\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$

# [ PS1 no git ]# {{{
#--------------------------------------------

# 简洁 传统 的 prompt
#PS1='\[\033[34m\]\t\[\033[1;31m\][\u@\h]\[\033[1;32m\]\w\[\033[m\]\$'
#PS1='\[\033[1;31m\][ \u·\W ] > \[\033[m\]'

# 换行 绝对路径
#PS1='\[\033[1;32m\]\u @ \[\033[1;34m\]\w \[\033[1;33m\][ \d \t ] \n[ h:\! l:\# ]\[\033[1;31m\] $ \[\033[0;39m\]'
#PS1='\[\033[1;32m\]\u @ \[\033[1;34m\]\w \[\033[1;33m\] \n\[\033[1;31m\] $ \[\033[0;39m\]'

#PS1='\[\e[1;34m\]\w \n \$\[\e[0m\] '

# 用户名 只在右上角
#PS1="\[\e[1;31m\] \W \$ \[\e[s\]\[\e[1;\$((COLUMNS-5))f\]\[\e[1;32m\]\$(whoami)\[\e[u\]\[\e[0m\]"

# }}}

# 原生的 git 分支提示
#PS1='[\u@\h`__git_ps1` \W]\$ '

# [ 色块 color 标记 git 状态 ]#{{{
#--------------------------------------------
# Colorful bash prompt reflecting Git status
# From : http://opinionated-programmer.com/2011/01/colorful-bash-prompt-reflecting-git-status/

function _git_prompt() {

local git_status="`git status -unormal 2>&1`"
if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
	if [[ "$git_status" =~ nothing\ to\ commit ]]; then
		local ansi=42
	elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
		local ansi=43
	else
		local ansi=45
	fi
	if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
		branch=${BASH_REMATCH[1]}
		test "$branch" != master || branch=' '
	else
		# Detached HEAD. (branch=HEAD is a faster alternative.)
		branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
			echo HEAD`)"
	fi
	echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
fi
}

#function _prompt_command() {
#PS1="`_git_prompt`"'... your usual prompt goes here, e.g. \[\e[1;34m\]\w \$\[\e[0m\] '
#}
#PROMPT_COMMAND=_prompt_command

if [ -n "$SSH_CLIENT" ]; then
	#PS1='\[\e[0;33m\]\u@\h:\wSSH$\[\e[m\] '
	#PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\wSSH\[\e[m\] \[\e[1;32m\]\$\[\    e[m\] '
	#PS1="\[\e[1;31m\] \W-ssh- \$ \[\e[s\]\[\e[1;\$((COLUMNS-5))f\]\[\e[1;32m\]\$(whoami)\[\e[u\]\[\e[0m\]"
	PS1='\[\033[34m\]\t[SSH]\[\033[1;31m\][\u@\h]\[\033[1;32m\]\w\[\033[m\]\$'

else
	PS1="`_git_prompt`"'\[\e[1;34m\]\w \n \$\[\e[0m\] '
fi

#PS1="`_git_prompt`"'\w \n \$ '


#function _prompt_command() {
# PS1="`_git_prompt`"'\w \n \$ '
# #PS1="`_git_prompt`"
# #PS1="`_git_prompt`"'${debian_chroot:+($debian_chroot)}\[\e[1;34m\]\w \n \$\[\e[0m\] '
#}
#PROMPT_COMMAND=_prompt_command

#}}}

## [ bash git branch prompt ]#{{{
##--------------------------------------------
## http://nuts-and-bolts-of-cakephp.com/2010/11/27/show-git-branch-in-your-bash-prompt/
#
##showing git branches in bash prompt
#function parse_git_branch {
# GIT BRANCH --NO-COLOR 2> /DEV/NULL | SED -E '/^[^*]/D' -E 'S/* \(.*\)/(\1)/'
#}
#
#function proml {
# local RED="\[\033[0;31m\]"
# local LIGHT_RED="\[\033[1;31m\]"
# local YELLOW="\[\033[0;33m\]"
# local LIGHT_GREEN="\[\033[1;32m\]"
# local WHITE="\[\033[1;37m\]"
# local LIGHT_GRAY="\[\033[0;37m\]"
# local LIGHT_PURPLE="\[\033[1;34m\]"
# case $TERM in
# xterm*)
# TITLEBAR='\[\033]0;\u@\h:\w\007\]'
# ;;
# *)
# TITLEBAR=""
# ;;
# esac
#
#PS1="${TITLEBAR}\
	#$LIGHT_PURPLE\w$YELLOW\$(parse_git_branch)\
	#\n$LIGHT_GRAY\$ "
#PS2='> '
#PS4='+ '
#}
#proml
#
##}}}
#
## [ bash git 箭头 / 雷电字符 ]#{{{
##--------------------------------------------
## From : https://gist.github.com/634750
## From : https://gist.github.com/738048
#
# RED="\[\033[0;31m\]"
# YELLOW="\[\033[0;33m\]"
# GREEN="\[\033[0;32m\]"
# BLUE="\[\033[0;34m\]"
# LIGHT_RED="\[\033[1;31m\]"
#LIGHT_GREEN="\[\033[1;32m\]"
# WHITE="\[\033[1;37m\]"
# LIGHT_GRAY="\[\033[0;37m\]"
# COLOR_NONE="\[\e[0m\]"
#
#function parse_git_branch {
#
# git rev-parse --git-dir &> /dev/null
# git_status="$(git status 2> /dev/null)"
# branch_pattern="^# On branch ([^${IFS}]*)"
# remote_pattern="# Your branch is (.*) of"
# diverge_pattern="# Your branch and (.*) have diverged"
# if [[ ! ${git_status}} =~ "working directory clean" ]]; then
#state="${RED}⚡"
# fi
# # add an else if or two here if you want to get more specific
# if [[ ${git_status} =~ ${remote_pattern} ]]; then
#if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
#remote="${YELLOW}↑"
# else
#remote="${YELLOW}↓"
# fi
#fi
#if [[ ${git_status} =~ ${diverge_pattern} ]]; then
#remote="${YELLOW}↕"
# fi
#if [[ ${git_status} =~ ${branch_pattern} ]]; then
#branch=${BASH_REMATCH[1]}
# echo " (${branch})${remote}${state}"
# fi
#}
#
#function prompt_func() {
# previous_return_value=$?;
# prompt="${TITLEBAR}${BLUE}[${LIGHT_GRAY}\w${GREEN}$(parse_git_branch)${BLUE}]${COLOR_NONE} "
# if test $previous_return_value -eq 0
# then
#PS1="${prompt}➔ "
# else
#PS1="${prompt}${RED}➔${COLOR_NONE} "
# fi
#}
#
## XXX 和下面 tmux / screen 标题栏 定义的 PROMPT_COMMAND 冲突
#PROMPT_COMMAND=prompt_func
#
##}}}
#




#}}}

# [ bash set 变量设置 ]# {{{
#--------------------------------------------

# bash 使用 vi 风格的行编辑
#set -o vi

#set editing-mode vi
#set show-all-if-ambiguous on
#set completion-ignore-case on
#set meta-flag on
#set convert-meta off
#set output-meta on
#set bell-style visible


# }}}

# [ man 手册 颜色 ]#{{{
#--------------------------------------------
# same to .zshrc
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[1;32m' # begin underline
#}}}

# [ history 历史记录 ]# {{{
#--------------------------------------------

#datestamp_history(){
#export infodate=`date “+: %c”`
#export infohis=`history 1`
#echo $infodate’ => ‘$infohis >> $HOME/.history-timestamp
#}
#export PROMPT_COMMAND=datestamp_history

#--------------------------------------------

# 去除重复历史记录。bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# HISTSIZE 控制历史命令记录的总行数,默认 500
export HISTSIZE=1000
export HISTFILESIZE=2000

# 禁用 history，,将 HISTSIZE 设置为 0
#export HISTSIZE=0

# HISTIGNORE 忽略历史中的特定命令, 将忽略 pwd、ls、ls -ltr 等命令：
export HISTIGNORE="ls:ls -ltr:ll:la:cd:clear:"

# 重复的命令，多个 shell 可能会干扰各自的历史记录，在 shell 中执行 shopt -s histappend

# 移除 shell 历史记录中连续的重复命令，清除整个命令历史中的重复条目 erasedups 参数
export HISTCONTROL=erasedups

# 使用 HISTTIMEFORMAT 显示时间戳
#export HISTTIMEFORMAT='%F %T '

# HISTFILE 更改历史文件名称
#HISTFILE=/root/.commandline_warrior







# }}}

## [ SSH AUTH SOCK 连接 ]#{{{
##--------------------------------------------
## SSH agent forwarding versus GNU screen
## http://onetom.posterous.com/ssh-agent-forwarding-versus-gnu-screen
#
## XXX 对 rsync / git / darcs 等使用 ssh 作为传输层的程序
## 需要判断是否是 交互式 ssh ( interactive session )
#
## 如果已经 建立链接文件 或是 rsync 链接调用 ssh 不会建立链接文件
#if [ "$SSH_TTY" -a "$SSH_AUTH_SOCK" != ~/.screen.sock ]; then
# ln -sfn $SSH_AUTH_SOCK ~/.screen.sock
# export SSH_AUTH_SOCK=~/.screen.sock
#fi
#
##}}}

# [ screen / tmux 标题栏 ]# {{{
#--------------------------------------------
# terminal, bash和screen的配合
# http://www.adam8157.info/blog/2010/05/terminal-bash-screen/

## 和默认 $PS1 可以实现 虚拟路径标题 + 应用程序题栏 [?]
case $TERM in
	xterm*)

		#PROMPT_COMMAND='echo -ne "\033]0;xterm @ ${PWD}\007"'
		#export PROMPT_COMMAND
		#PS1="${PS1}"

		# GNU Screen auto title on gentoo
		# http://www.devhands.com/2008/08/gnu-screen-auto-title-on-gentoo/
		#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'

		#PATHTITLE='\[\ek\W\e\\\]'
		## 程序标题
		#PROGRAMTITLE='\[\ek\e\\\]'
		#PS1="${PROGRAMTITLE}${PATHTITLE}${PS1}"

		;;
	screen*)

		#unset PROMPT_COMMAND
		#PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		#PS1='\[\033k\033\\\]'$PS1

		# 路径标题
		PATHTITLE='\[\ek\W\e\\\]'
		# 程序标题
		PROGRAMTITLE='\[\ek\e\\\]'
		PS1="${PROGRAMTITLE}${PATHTITLE}${PS1}"

		# 重定义 ssh 在 screen 标题栏显示为主机名，而非单调的 ssh
		# GNU/screen and dynamic titles for SSH
		# http://dischord.org/blog/2006/11/22/gnuscreen-and-dynamic-titles-for-ssh/
		#function ssh() {
		#echo -n -e "\033k$1\033\134″"
		#/usr/bin/ssh $@
		#echo -n -e "\033k`hostname -s`\033\134″"
		#}

		function ssh() {
		# XXX 未知 \134
		echo -n -e "\033k@`echo $1|sed 's:.*@::'`\033\134″"
		/usr/bin/ssh $@
		# [?] 这句何时打印
		#echo -n -e "\033k`hostname -s`\033\134″"
		#echo -n -e "\033k`echo $@|sed 's:.*@::'`\033\134″"
	}

	#function telnet() {
	#echo -n -e "\033k$1\033\134″"
	#/usr/bin/telnet $@
	#echo -n -e "\033k`hostname -s`\033\134″"
	#}

	;;
rxvt)
	PROMPT_COMMAND='echo -ne "\033]0;urxvt : ${PWD}\007"'
	export PROMPT_COMMAND
	;;
*)
	;;
esac

# }}}

## [ RED HAT /etc/bashrc ]#{{{
##--------------------------------------------
#
#if [ "$PS1" ]; then
# case $TERM in
# xterm*)
# if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
# PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
# else
# PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
# fi
# ;;
# screen)
# if [ -e /etc/sysconfig/bash-prompt-screen ]; then
# PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
# else
# PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\033\\"'
# fi
# ;;
# *)
# [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
# ;;
# esac
# # Turn on checkwinsize
# shopt -s checkwinsize
# [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "
#fi
#
##}}}

## [ vim wiki ]#{{{
##--------------------------------------------
## http://vim.wikia.com/wiki/Automatically_set_screen_title
## 可以 PROMPT_COMMAND 没有被覆盖，可以实现动态修改标题栏
## 但是会在 $PS1 前输出 134 ，\134 表示意义未知
#
#case $TERM in
# xterm*|rxvt*)
# PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}[`basename ${PWD}`]\007"'
# ;;
# screen*)
# PROMPT_COMMAND='echo -ne "\033k\033\134\033k[`basename ${PWD}`]\033\134"'
# ;;
# *)
# ;;
#esac
#
##}}}

