#! /bin/false
# Add "xworld"-site binaries to $PATH.


PATH=/usr/local/bin/xworld${PATH:+:}$PATH
if test x`id -u` = x0; then
	PATH=/usr/local/sbin/xworld${PATH:+:}$PATH
fi
export PATH
