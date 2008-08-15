#! /bin/false
# Add "xworld"-site binaries to $PATH.


PATH=`(
	OPATH=$PATH
	PATH=/sbin/:/bin:/usr/sbin:/usr/bin
	set --
	# Add significant directory name components in the order to be added.
	test x\`id -u\` = x0 && set -- "$@" sbin
	set -- "$@" bin
	NPATH=
	for BIN in "$@"; do
		# Subdirectories to be added in the order to be added.
		# But in any case, only directories which actually exist
		# will be added!
		for SUB in \
			machine_local \
			site_internal \
			xworld_internal \
			xworld
		do
			NEW=/usr/local/$BIN/$SUB
			test -d "$NEW" || continue
			NPATH=$NPATH${NPATH:+:}$NEW
		done
	done
	test -n "$OPATH" && test -n "$NPATH" && NPATH=$NPATH:
	printf "%s\n" "$NPATH$OPATH"
)`
export PATH
