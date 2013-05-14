#! /bin/false
# Add "xworld"-site binaries to $PATH.

setup_j10k7jchg30nz1gd5gpc46ufr() {
	local sub issu
	set --
	case `id -u` in
		0) issu=Y;;
		*) issu=
	esac
	# These paths will be added in the *reverse* order specified here,
	# and only if they actually exist.
	for sub in \
		machine_local \
		site_internal \
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
