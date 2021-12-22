#!/bin/sh

ACTION="purging"
TARGET="packages"

. ./lib/env.sh

if [ -n "$1" ]; then
	export PROJECT_ID=$(printf "%s" "$1" | jq -sRr @uri)
else
	printf "%s\n"   "You must provide a repo to target"
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo>";
	exit;
fi;

printf "%s %s\n" "$ACTION", "$TARGET"
PACKAGES=$(curl --silent \
	--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
	"https://$GITLAB_HOST/api/v4/projects/$PROJECT_ID/$TARGET" |
	jq -r .[].id
)
for id in $PACKAGES; do
	curl --request DELETE \
		--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
		"https://$GITLAB_HOST/api/v4/projects/$PROJECT_ID/$TARGET/$id"
done;
printf "\t... done %s %s\n" "$ACTION" "$TARGET";
