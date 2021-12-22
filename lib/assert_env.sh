#!/bin/sh

if [ -z "$GITLAB_TOKEN" ]; then
	printf "You must set GITLAB_TOKEN in the environment\n"
	printf "\tGITLAB_TOKEN=\"mytoken\" %s <args>\n"         "$0"
	printf "\tsee \"%s --help\" for more information\n"     "$0"
	exit 1;
fi;

if [ -z "$GITLAB_HOST" ]; then
	printf "You must set GITLAB_HOST in the environment\n"
	printf "\tGITLAB_HOST=\"myhost\" %s <args>\n"         "$0"
	printf "\tsee \"%s --help\" for more information\n"     "$0"
	exit 2;
fi;
