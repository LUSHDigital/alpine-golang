FROM golang:1.13-alpine
RUN apk update && \
    apk --no-cache add \
        ca-certificates \
        tzdata \
        git \
        upx

ONBUILD ARG APPBIN="build/service"
ONBUILD ENV APPBIN=${APPBIN}

ONBUILD ARG GOTARGET="service/*.go"
ONBUILD ENV GOTARGET=${GOTARGET}

ONBUILD ARG GOPROXY
ONBUILD ENV GOPROXY=${GOPROXY}

ENV CGO_ENABLED="0"

# The build script contains everything you need for building the service/ directory in your project.
COPY build.sh /build.sh

ONBUILD WORKDIR /repo
ONBUILD COPY . .
ONBUILD RUN /build.sh
