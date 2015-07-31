# /bin/false
# Customized the $PATH environment variable for the compiler cache, if any.


# Returns true if $1 is part of $FEATURES in "/etc/portage/make.conf".
is_feature_enabled_gb0rlkm7jmpw6fq6e20mreb13() {
	local FEATURES FEATURE
	FEATURES="`. /etc/portage/make.conf; echo \"$FEATURES\"`"
	for FEATURE in $FEATURES
	do
		test x"$FEATURE" = x"$1" && return
	done
	false || return
}


env_var_gb0rlkm7jmpw6fq6e20mreb13() {
	local VNAME WHAT DIR WHERE ACTION
	while test $# != 0
	do
		case $1 in
			--insert) ACTION=i WHAT=$2;;
			--after) DIR=a WHERE=$2;;
			--before) DIR=b WHERE=$2;;
			--into) VNAME=$2
		esac
		shift 2
		case $ACTION${WHAT:+1}${WHERE:+2}${VNAME:+3}$DIR in
			i123a | i123b)
				local OLD NEW PC DONE OIFS
				eval OLD=\"\$$VNAME\"
				OIFS=$IFS
				local IFS=:
				for PC in $OLD
				do
					IFS=$OIFS
					test x"$PC" = x && continue
					if test x"$DIR" = x"a"
					then
						NEW=$NEW${NEW:+:}$PC
					fi
					if test x"$WHERE" = x"$PC"
					then
						NEW=$NEW${NEW:+:}$WHAT
						DONE=1
					fi
					if test x"$DIR" = x"b"
					then
						NEW=$NEW${NEW:+:}$PC
					fi
				done
				if test -z "$DONE"
				then
					echo "Warning: \$$VNAME" \
						"does not contain" \
						"'$WHERE'!" >& 2
				fi
				eval $VNAME=\"$NEW\"
				return
			;;
		esac
	done
}


insert_before_gcc_gb0rlkm7jmpw6fq6e20mreb13() {
	local GCC
	GCC=`which gcc`
	GCC=${GCC%/*}
	test -d "$GCC" || return
	env_var_gb0rlkm7jmpw6fq6e20mreb13 \
		--insert "$1" --before "$GCC" --into PATH
}


if is_feature_enabled_gb0rlkm7jmpw6fq6e20mreb13 ccache
then
	insert_before_gcc_gb0rlkm7jmpw6fq6e20mreb13 "/usr/lib/ccache/bin"
fi
if is_feature_enabled_gb0rlkm7jmpw6fq6e20mreb13 distcc
then
	insert_before_gcc_gb0rlkm7jmpw6fq6e20mreb13 "/usr/lib/distcc/bin"
fi


unset -f is_feature_enabled_gb0rlkm7jmpw6fq6e20mreb13 \
	env_var_gb0rlkm7jmpw6fq6e20mreb13 \
	insert_before_gcc_gb0rlkm7jmpw6fq6e20mreb13
