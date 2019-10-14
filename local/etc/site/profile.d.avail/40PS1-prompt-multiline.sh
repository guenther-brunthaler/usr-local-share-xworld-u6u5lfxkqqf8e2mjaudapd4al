#! /bin/sh
# Set up a multi-line prompt where the current directory is shown in an
# individual line. This avoids making the shell prompt part in the line
# containing the cursor too long in case of a long current directory path.
#
# Version 2019.287
#
# Copyright (c) 2019 Guenther Brunthaler. All rights reserved.
#
# This script is free software.
# Distribution is permitted under the terms of the GPLv3.

case $- in
	*i*) ;;
	*) return
esac

if test -x /usr/bin/tput && tput setaf > /dev/null 2>& 1
then
	PS1='\n\[\033[0;33m\]cwd: \w\[\033[0m\]\n'
	PS1=$PS1'\[\033[01;3'`
		case \`id -u\` in
			0) echo 1;;
			*) echo 2
		esac
	`'m\]\u@\h\[\033[00m\]'
	PS1=$PS1'\[\033[01;34m\] \$\[\033[00m\] '
else
	PS1='\ncwd: \w\n'
	PS1=$PS1'\u@\h'
	PS1=$PS1' \$ '
fi
