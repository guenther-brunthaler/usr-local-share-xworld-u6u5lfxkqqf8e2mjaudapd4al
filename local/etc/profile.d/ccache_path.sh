# Customized the $PATH environment variable for the compiler cache, if any.


# Returns true if $1 is part of $FEATURES in "/etc/portage/make.conf".
is_feature_enabled() {
	local FEATURES FEATURE
	FEATURES="`. /etc/portage/make.conf; echo $FEATURES`"
	for FEATURE in $FEATURES; do
		test "$FEATURE" = "$1" && return
	done
	return 1
}


env_var() {
	local VNAME WHAT DIR WHERE ACTION
	while [ $# != 0 ]; do
		case "$1" in
			--insert) ACTION=i WHAT="$2";;
			--after) DIR=a WHERE="$2";;
			--before) DIR=b WHERE="$2";;
			--into) VNAME="$2";;
		esac
		shift; shift
		case "$ACTION${WHAT:+1}${WHERE:+2}${VNAME:+3}$DIR" in
			i123a | i123b)
				local OLD NEW PC DONE OIFS
				eval OLD=\"\$$VNAME\"
				OIFS="$IFS"
				local IFS=:
				for PC in $OLD; do
					IFS="$OIFS"
					test "$PC" = "" && continue
					if [ "$DIR" = "a" ]; then
						NEW="$NEW${NEW:+:}$PC"
					fi
					if [ "$WHERE" = "$PC" ]; then
						NEW="$NEW${NEW:+:}$WHAT"
						DONE=1
					fi
					if [ "$DIR" = "b" ]; then
						NEW="$NEW${NEW:+:}$PC"
					fi
				done
				if [ -z "$DONE" ]; then
					echo "Warning: \$$VNAME" \
						"does not contain" \
						"'$WHERE'!" > /dev/stderr
				fi
				eval $VNAME=\"$NEW\"
				return
			;;
		esac
	done
}


insert_before_gcc() {
	local GCC
	GCC="$(which gcc)"
	GCC="${GCC%/*}"
	test -d "$GCC" || return
	env_var --insert "$1" --before "$GCC" --into PATH
}


if is_feature_enabled ccache; then
	insert_before_gcc "/usr/lib/ccache/bin"
fi
if is_feature_enabled distcc; then
	insert_before_gcc"/usr/lib/distcc/bin"
fi


unset -f is_feature_enabled env_var insert_before_gcc
