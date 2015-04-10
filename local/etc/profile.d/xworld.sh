#! /bin/false
# Add "xworld"-site binaries to $PATH.

setup_j10k7jchg30nz1gd5gpc46ufr() {
	local sub issu dist
	set --
	case `id -u` in
		0) issu=Y;;
		*) issu=
	esac
	dist=`
		exec 2> /dev/null
		lsb_release -i | tr A-Z a-z | sed '
			s,.*:[^a-z0-9]*,,
			s/[^0-9a-z]/_/g
			s/__*/_/g
			s/_$//
		'
	` || dist=
	test -n "$dist" && dist=xworld_$dist
	# These paths will be added in the order specified here, and only if
	# they actually exist.
	for sub in \
		machine_local \
		site_internal \
		$dist \
		xworld_internal \
		xworld
	do
		test -n "$issu" && set -- "$@" --append /usr/local/sbin/$sub
		set -- "$@" --append /usr/local/bin/$sub
	done
	. /usr/local/libexec/xworld/sh/path_hyec3v5m8kd1vjs8k7d1wce62.sh
	export PATH
}
setup_j10k7jchg30nz1gd5gpc46ufr
unset -f setup_j10k7jchg30nz1gd5gpc46ufr
