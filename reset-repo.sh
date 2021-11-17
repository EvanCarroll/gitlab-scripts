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
elif [ -n "$1" ]; then
	export PROJECT_ID=$(printf "%s" "$1" | jq -sRr @uri)
else
	printf "%s\n"   "You must provide a repo to target"
	printf "\t%s\n" "GITLAB_TOKEN=\"mytoken\" $0 <repo>";
	exit;
fi;

if [ -n "$PURGE_TAGS" ]; then
	printf "purging %s\n" "tags";
	TAGS=$(curl --silent \
		--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
		"https://gitlab.awe.eco.cpanel.net/api/v4/projects/$PROJECT_ID/repository/tags" |
		jq -r .[].name
	);
	for id in $TAGS; do
		curl --request DELETE \
			--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
			"https://gitlab.awe.eco.cpanel.net/api/v4/projects/$PROJECT_ID/repository/tags/$id"
	done;
	printf "\t... done purging %s\n" "tags";
fi;


if [ -n "$PURGE_RELEASES" ]; then
	printf "purging %s\n" "releases";
	RELEASES=$(curl --silent \
		--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
		"https://gitlab.awe.eco.cpanel.net/api/v4/projects/$PROJECT_ID/releases" |
		jq -r .[].tag_name
	);
	for id in $RELEASES; do
		curl --request DELETE \
			--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
			"https://gitlab.awe.eco.cpanel.net/api/v4/projects/$PROJECT_ID/releases/$id"
	done;
	printf "\t... done purging %s\n" "releases";
fi;

if [ -n "$PURGE_PACKAGES" ]; then
	printf "purging %s\n" "packages";
	PACKAGES=$(curl --silent \
		--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
		"https://gitlab.awe.eco.cpanel.net/api/v4/projects/$PROJECT_ID/packages" |
		jq -r .[].id
	)
	for id in $PACKAGES; do
		curl --request DELETE \
			--header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
			"https://gitlab.awe.eco.cpanel.net/api/v4/projects/$PROJECT_ID/packages/$id"
	done;
	printf "\t... done purging %s\n" "releases";
fi;

printf "%s\n" "done.";
