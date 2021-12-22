GitLab Scripts
====

These are just some scripts I wrote to help maintain and set up GitLab CI
pipelines.

While this is massively faster than using the UI, it's currently **needed**
because [you can not currently delete a GitLab release after it's
created](https://stackoverflow.com/q/54418978/124486)

Currently there is one script for resetting a repo

* [`reset-repo.sh`](./reset-repo.sh) which deletes all tags, packages, and
	GitLab Releases associated with a project (git repository).

This works by calling smaller scripts in `purge` (which you can target too).
There are also multiple smaller scripts for downloading artifacts in
`./artifacts`.

All of the scripts are invoked like this,

```sh
GITLAB_HOST="gitlab.foo.bar" GITLAB_TOKEN="mytoken" ./reset-repo.sh <repo>
```

Alternatively you can set these variables in [`./.env`](./.env)
