#!/bin/sh

ACTION="purging"
TARGET="releases"

. lib/env.sh

if [ -z "$1" ] || [ -z "$2" ]; then
	printf "%s\n"   "You must provide a repo to target"
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo> <release_id>";
	printf "\t%s\n" "ex\ $0 foo/bar v2.3.4";
	exit;
fi;

export PROJECT_ID=$(printf "%s" "$1" | jq -sRr @uri)
export ID="$2"

printf "%s %s\n" "$ACTION", "$TARGET"
curl --request DELETE \
	--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
	"https://$GITLAB_HOST/api/v4/projects/$PROJECT_ID/$TARGET/$ID"
printf "\t... done %s %s %s\n" "$ACTION" "$TARGET" "$ID";
