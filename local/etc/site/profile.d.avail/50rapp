#! /bin/false
# Run an application from the home directory in the
# background with any output redirected to /dev/null.
# If the -l or --local option is specified, the
# local current directory is not changed.
#
# Version 2019.287

if test "$DISPLAY"
then
	rapp() {
		if test "$#" = 1
		then
			(cd && "$@" > /dev/null 2>& 1) &
		else
			if test "$1" = -l || test "$1" = --local
			then
				shift
			fi
			"$@" > /dev/null 2>& 1 &
		fi
	}
fi
