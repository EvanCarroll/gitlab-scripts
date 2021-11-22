#!/bin/sh

ACTION="purging"
TARGET="tags"

if [ -z "$GITLAB_TOKEN" ]; then
	printf "%s\n"   "You must set GITLAB_TOKEN in the environment"
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo>"
	exit;
fi;

if [ -n "$1" ]; then
	export PROJECT_ID=$(printf "%s" "$1" | jq -sRr @uri)
else
	printf "%s\n"   "You must provide a repo to target"
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo>";
	exit;
fi;

printf "%s %s\n" "$ACTION", "$TARGET"
TAGS=$(curl --silent \
	--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
	"https://gitlab.awe.eco.cpanel.net/api/v4/projects/$PROJECT_ID/repository/$TARGET" |
	jq -r .[].name
);
for id in $TAGS; do
	curl --request DELETE \
		--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
		"https://gitlab.awe.eco.cpanel.net/api/v4/projects/$PROJECT_ID/repository/$TARGET/$id"
done;
printf "\t... done %s %s\n" "$ACTION" "$TARGET";
