#!/bin/sh

ACTION="purging"
TARGET="releases"

. lib/env.sh

if [ -n "$1" ]; then
	export PROJECT_ID=$(printf "%s" "$1" | jq -sRr @uri)
else
	printf "%s\n"   "You must provide a repo to target"
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo>";
	exit;
fi;

printf "%s %s\n" "$ACTION", "$TARGET"
RELEASES=$(curl --silent \
	--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
	"https://$GITLAB_HOST/api/v4/projects/$PROJECT_ID/$TARGET" |
	jq -r .[].tag_name
);
for id in $RELEASES; do
	curl --request DELETE \
		--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
		"https://$GITLAB_HOST/api/v4/projects/$PROJECT_ID/$TARGET/$id"
done;
printf "\t... done %s %s\n" "$ACTION" "$TARGET";
