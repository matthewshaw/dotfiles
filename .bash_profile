##
## Aliases/Environment
##

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
if [ `uname -o` == 'Cygwin' ]; then 
    export SSH_ASKPASS=""
    export GIT_ASKPASS=""
fi

if [[ -e "/usr/bin/ls" ]]; then
    alias ls='ls --color'
    alias dir=ls
fi

# Finds all git or svn working copies under a given directory
# Caveat: older .svn versions use multiple .svn directories
# and this command will return a ton of garbage for them
if [[ -e "/usr/bin/find" ]]; then
    alias getAllWorkingCopies='find . -name ".svn" -printf "%h\n"'
fi

export TERM=ansi

##
## Custom functions
##

function checkdeps() {
    local return=0

    for dep in $@; do
        if ! [[ -e $dep ]]; then
            echo "Did not find required binary $dep"
            return=-1
        fi
    done

   echo $return 
}

function tailr() {
    REFRESH_RATE=2
    DEPENDSON="/usr/bin/wget"
    if [[ ! $(checkdeps $DEPENDSON) -eq 0 ]]; then
        return;
    fi

    if [[ ! `expr match "$1" "http://"` ]]; then
        echo "Must specify an HTTP URL as the first argument"
        return
    fi

    if [[ -z $2 && $2 =~ '^[0-9+$' ]]; then
        REFRESH_RATE=$2
    fi

    while true; do
        /usr/bin/wget -qO- $1 | tail -200
        sleep $REFRESH_RATE

        if [[ $(checkdeps "/usr/bin/clear") -eq 0 ]]; then
            /usr/bin/clear
        else
            echo "/usr/bin/clear not found, consider installing curses for this to work propertly"
            sleep 1;
        fi
    done
}

##
## Inclusions
##

# Get local customizations if they exist
if [[ -e .local_bash_profile ]]; then
    . .local_bash_profile
fi

# Smart cd history, invoke with cd --, change to a dir in the list with cd -#
if [[ -e .acd_func.sh ]]; then
    . .acd_func.sh
fi

