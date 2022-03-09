GitLab Scripts
====

These are just some scripts I wrote to help maintain and set up GitLab CI
pipelines.

While this is massively faster than using the UI, it's currently **needed**
because [you can not currently delete a GitLab release after it's
created](https://stackoverflow.com/q/54418978/124486)

All of the scripts are invoked like this,

```sh
GITLAB_HOST="gitlab.foo.bar" GITLAB_TOKEN="mytoken" ./reset-repo.sh <repo>
```

**Alternatively you can set these variables in [`./.env`](./.env)**

Purge Download Scripts
----

* [`reset-repo.sh`](./reset-repo.sh) which deletes all tags, packages, and
	GitLab Releases associated with a project (git repository).

This works by calling smaller scripts in `purge` (which you can target too).
There are also multiple smaller scripts for downloading artifacts in
`./artifacts`.


Artifact Download Scripts
----

These scripts are located in `./artifacts`

* [`download-latest-archive-for-job.sh`](./artifacts/download-latest-archive-for-job.sh) downloads a **zip archive**. Called with a repo name, a branch name, and a pipeline job to download all of the artifacts in an archive, for example
  ```sh
  # Download all artifacts created by the create_doc_artifacts job on branch main on repo evancarroll/angular-ui
  sh ./artifacts/download-latest-archive-for-job.sh evancarroll/angular-ui main create_doc_artifacts
  ```

* [`download-latest-file-for-job.sh`](download-latest-file-for-job.sh), download a **single file**. Called as above, with an additional argument for the name of the file.
  ```sh
  # Same target as above, but this time just download the file `dist/compodoc/json/documentation.json`
  sh ./artifacts/download-latest-file-for-job.sh evancarroll/angular-ui main create_doc_artifacts dist/compodoc/json/documentation.json
  ```
