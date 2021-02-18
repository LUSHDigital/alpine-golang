#!/bin/sh

CURRENT_REVISION=$(git rev-parse --verify HEAD)
LATEST_TAG_COMMIT=$(git rev-list --tags --max-count=1)
LATEST_TAG=$(git describe --tags ${LATEST_TAG_COMMIT} 2>/dev/null)

go build \
    -o ${APPBIN} \
    -mod=vendor \
    -ldflags "
        -X main.ref=${CURRENT_REVISION}
        -X main.tag=${LATEST_TAG}
        -X github.com/LUSHDigital/core.ref=${CURRENT_REVISION}
        -X github.com/LUSHDigital/core.tag=${LATEST_TAG}
    " \
    ${GOTARGET}
