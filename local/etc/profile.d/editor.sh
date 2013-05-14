# Overrides the system default editor.
#
# If you *really* prefer nano, comment out the lines below.
# But then again, who does?

if test -f /usr/bin/joe
then
	EDITOR=/usr/bin/joe
fi

VISUAL=$EDITOR
export EDITOR VISUAL
