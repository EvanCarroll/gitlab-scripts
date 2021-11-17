GitLab Scripts
====

These are just some scripts I wrote to help maintain and set up GitLab CI
pipelines.

While this is massively faster than using the UI, it's currently **needed**
because [you can not currently delete a GitLab release after it's
created](https://stackoverflow.com/q/54418978/124486)

Currently there is one script,

* [`reset-repo.sh`](./reset-repo.sh) which deletes all tags, packages, and
	GitLab Releases associated with a project (git repository).
