#!/bin/sh

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
	cat <<-EOF
		Downloads an archive of artifacts on the latest successful pipeline for a
		specific job on a given repo and branch
	EOF
	printf "\t%s\n" "$0 <repo> <branch> <job>";
	printf "\t%s\n" "ex\ $0 foo/bar main publish_docs";
	exit;
fi;

. lib/env.sh
	
if [ -z "$1" ] || [ -z "$2" ]; then
	printf "%s\n"   "You must provide a repo, branch, and job to target"
	printf "\t%s\n" "$0 <repo> <branch> <job>";
	printf "\t%s\n" "ex\ $0 foo/bar main publish_docs";
	exit;
fi;

export PROJECT_ID=$(printf "%s" "$1" | jq -sRr @uri)
export BRANCH="$2"
export JOB="$3"

curl --silent \
	--output artifacts.zip                  \
	--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
	"https://$GITLAB_HOST/api/v4/projects/$PROJECT_ID/jobs/artifacts/$BRANCH/download?job=$JOB";

printf "%s\n" "done.";
