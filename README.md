# nodejs-sample-justfile-build-system

This project's aim is to illustrate how to use a `Justfile` as a build system for a Node.js project, in this case the project is a Next.JS app.

just is a handy way to save and run project-specific commands.

You can install **just** by checking out [the installation instructions](https://just.systems/man/en/chapter_4.html).

The `Justfile` in this project has 6 recipes:
```
build               # build application for production
default             # run the "dev" recipe
deps                # install project dependencies
dev install='false' # start server in dev mode
image               # build docker image for application
run-image           # run application in a docker image
```

You can list them by running `just --list` in this directory.

You can run them with `just <recipe>`.

The Justfile is [located here](https://github.com/kevinchar93/nodejs-sample-justfile-build-system/blob/main/Justfile), and annotated version of the same file [is located here](https://github.com/kevinchar93/nodejs-sample-justfile-build-system/blob/main/annotated-justfile/Justfile).