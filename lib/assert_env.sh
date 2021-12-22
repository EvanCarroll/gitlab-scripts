#!/bin/sh

NO_REPO=1;

if [ -z "$GITLAB_TOKEN" ]; then
	printf "You must set GITLAB_TOKEN in the environment\n"
	printf "\tGITLAB_TOKEN=\"mytoken\" %s <args>\n"         "$0"
	printf "\tsee \"%s --help\" for more information\n"     "$0"
	exit $NO_REPO;
fi;
