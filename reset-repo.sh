#!/bin/sh

export PURGE_TAGS=1;
export PURGE_RELEASES=1;
export PURGE_PACKAGES=1;

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
	cat <<-EOF
		Remove tags, releases, and packages from a repo, effectively reseting it to
		assist in tooling development
	EOF
	printf "\t%s\n" "$0 <repo>";
	exit;
fi;

. lib/env.sh

if [ -z "$1" ]; then
	printf "%s\n"   "You must provide a repo to target"
	printf "\t%s\n" "$0 <repo>";
	exit;
fi;

if [ "$PURGE_PACKAGES" = 1 ]; then
	sh ./purge/packages.sh "$1"
	if [ -x "hooks/purge/packages/post" ]; then
		./hooks/purge/packages/post "$1"
	fi;
fi;

if [ "$PURGE_TAGS" = 1 ]; then
	sh ./purge/tags.sh "$1"
	if [ -x "hooks/purge/tags/post" ]; then
		./hooks/purge/tags/post "$1"
	fi;
fi;


if [ "$PURGE_RELEASES" = 1 ]; then
	sh ./purge/releases.sh "$1"
	if [ -x "hooks/purge/releases/post" ]; then
		./hooks/purge/releases/post "$1"
	fi;
fi;

if [ -x "hooks/post" ]; then
	./hooks/purge/post
fi;

printf "%s\n" "done.";


printf "** %s **" "DO NOT FORGET"
printf "** %s **" "AFTER RESET IF FORCE PUSHING TO USE --tags"
printf "\t%s"     "ie\ git push origin main --tags --force"
