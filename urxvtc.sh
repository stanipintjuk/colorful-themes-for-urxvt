#!/bin/bash

themedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#define some theme sequence
theme[0]="blue"
theme[1]="green"
theme[2]="pink"
theme[3]="purple"

#check for last used theme id
if [ ! -f "/tmp/termtheme" ] ; then
	theme_id=0 #defaulting to first theme
else
	theme_id=`cat /tmp/termtheme` #load previous
	theme_id=`expr ${theme_id} + 1` #increment it
	theme_id=`expr ${theme_id} % ${#theme[@]}` #don't exceed max
fi

#store theme id we're about to use
echo "${theme_id}" > /tmp/termtheme

bcimgnum=$(( ( RANDOM % 10 ) + 1 ))

xrdb ~/.Xresources
xrdb -merge "${themedir}/${theme[$theme_id]}" 
echo urxvt -pixmap "${themedir}/res/bcimg${foldnum}.png" $@

env URXVT_THEME=${theme[${theme_id}]} urxvt -pixmap "${themedir}/res/bcimg${bcimgnum}.png" $@
