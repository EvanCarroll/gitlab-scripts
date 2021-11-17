#!/bin/sh

export PURGE_TAGS=1;
export PURGE_RELEASES=1;
export PURGE_PACKAGES=1;

if [ -z "$GITLAB_TOKEN" ]; then
	printf "%s\n"   "You must set GITLAB_TOKEN in the environment"
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo>"
	exit;
fi;

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
	cat <<-EOF
		Remove tags, releases, and packages from a repo, effectively reseting it to
		assist in tooling development
	EOF
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo>";
	exit;
fi;

if [ -z "$1" ]; then
	printf "%s\n"   "You must provide a repo to target"
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo>";
	exit;
fi;

if [ -n "$PURGE_TAGS" ]; then
	sh ./purge/tags.sh "$1"
fi;


if [ -n "$PURGE_RELEASES" ]; then
	sh ./purge/releases.sh "$1"
fi;

if [ -n "$PURGE_PACKAGES" ]; then
	sh ./purge/packages.sh "$1"
fi;

printf "%s\n" "done.";
