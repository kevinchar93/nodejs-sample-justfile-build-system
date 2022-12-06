# A Justfile for a NextJS project

# see the file `Justfile-Annotated` for a fully annotated version of this Justfile
# - https://github.com/kevinchar93/nodejs-sample-justfile-build-system/blob/main/annotated-justfile/Justfile

# run the "dev" recipe
default: dev

PROJECT_NAME := `jq '.name' package.json`
PROJECT_VERSION := `jq '.version' package.json`
NODE_BIN_DIR := `npm bin`

# install project dependencies
deps:
    @echo 'Install dependencies for {{PROJECT_NAME}}...'
    npm install
    @echo 'Done.'


# start server in dev mode
dev install='false':
    @if [[ "{{lowercase(install)}}" =~ ^(install)$ ]]; then just deps; fi
    @{{NODE_BIN_DIR}}/next dev


# build application for production
build:
    @echo 'Build project {{PROJECT_NAME}}'
    npm ci
    @{{NODE_BIN_DIR}}/next build
    @echo 'Done.'


IMAGE_TAG:= PROJECT_NAME + ":" + PROJECT_VERSION
# build docker image for application
image:
    @echo 'Build container image for {{PROJECT_NAME}} version {{PROJECT_VERSION}}'
    docker build --tag {{IMAGE_TAG}} .
    @echo 'Done.'


CONTAINER_NAME := PROJECT_NAME + "-" + PROJECT_VERSION + "-instance"
# run application in a docker image
run-image: image
    @echo 'Running container image {{PROJECT_NAME}}:{{PROJECT_VERSION}}'
    docker run --name {{CONTAINER_NAME}} -p 3000:3000 {{IMAGE_TAG}}
