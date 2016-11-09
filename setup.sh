#!/bin/bash

SCRIPT_LOCATION=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

. "$SCRIPT_LOCATION/.bash_profile"

NAME="$1"
EMAIL="$2"

SED=`which sed`
if [[ "$NAME" != "" && "$EMAIL" != "" ]]; then
    if [[ $(checkdeps "$SED") -eq 0 ]]; then
        $SED -i "s/<NAME>/$NAME/g" "$SCRIPT_LOCATION"/.gitconfig
        $SED -i "s/<EMAIL>/$EMAIL/g" "$SCRIPT_LOCATION"/.gitconfig
    fi
fi

FILES_TO_LINK=`ls -d "$SCRIPT_LOCATION"/.* | egrep -v '(^|/)\.git$|(^|/)\.\.?$'`

IFS=$(echo -en "\n\b")
for file in $FILES_TO_LINK; do
  DEST=~/$(basename "$file")
    if [ -e $DEST ]; then
        rm $DEST;
    fi
    ln -s "$file" $DEST
done
