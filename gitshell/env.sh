#!/bin/zsh

#
#  Utility adds all RSA keys to Agent (ssh) on console startup for this user session (mac).
#  But on Windows Agent session lives into one console process (window)
#  and resets if you close console window.
#
#  Утилита добавляет все RSA ключи в ssh агент во время запуска консоли.
#  Ключи работают для текущей сессии пользователя ОС (на маке)
#  А на Windows у меня приходилось каждый раз добавлять ключи
#  Для каждой сессии консоли, причем ключи работали только в том окне,
#  где были добавлены
#

# PATH
# export PATH="/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export EDITOR='subl -w'
# export PYTHONPATH=$PYTHONPATH
# export MANPATH="/usr/local/man:$MANPATH"

# Virtual Environment
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
# source /usr/local/bin/virtualenv.sh

# Owner
export USER_NAME="admin"
eval "$(rbenv init -)"

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

#
# SSH login sets
#
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/another_rsa

elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/another_rsa

fi

unset env
