# source the users bashrc if it exists
if [[ -f "${HOME}/.bashrc" ]] ; then
  source "${HOME}/.bashrc"
fi

# Set PATH so it includes user's private bin if it exists
if [[ -d "${HOME}/bin" ]] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# Set MANPATH so it includes users' private man if it exists
if [[ -d "${HOME}/man" ]]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
if [[ -d "${HOME}/info" ]]; then
  INFOPATH="${HOME}/info:${INFOPATH}"
fi

if [[ -e "/usr/bin/vim" ]]; then
    export EDITOR=/usr/bin/vim
fi

if [[ -e "/usr/bin/less" ]]; then
    export PAGER=/usr/bin/less
    alias more="less -X"
fi

if [[ -e "/usr/bin/grep" ]]; then
    alias grep='grep --color'
    alias rgrep="grep -I -R --exclude-dir='.*'"
fi

# On Cygwin, don't try to run an X program to ask me for a password please
if [[ `uname -o` -eq 'Cygwin' ]]; then 
    export SSH_ASKPASS=""
    export GIT_ASKPASS=""
fi

if [[ -e "/usr/bin/ls" ]]; then
    alias ls='ls --color'
    alias dir=ls
fi

export TERM=ansi

# Smart cd history, invoke with cd --, change to a dir in the list with cd -#
. .acd_func.sh
