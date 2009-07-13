#! /bin/false
# Inserts bin directory for additional system-wide binaries into $PATH.

if test -d /home/group/admdevel/bin; then
	PATH=$PATH${PATH:+:}/home/group/admdevel/bin
fi
