FROM golang:1-alpine
RUN apk update && \
    apk --no-cache add \
        ca-certificates \
        tzdata \
        git

ARG GOMODPROXY

ENV CGO_ENABLED="0"
ENV GOPROXY=${GOMODPROXY}

# The build script contains everything you need for building the service/ directory in your project.
COPY build.sh /build.sh

ONBUILD WORKDIR /repo
ONBUILD COPY . .
ONBUILD RUN /build.sh
