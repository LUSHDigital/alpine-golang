FROM golang:1.13-alpine
RUN apk update && \
    apk --no-cache add \
        ca-certificates \
        tzdata \
        git

ARG GOTARGET="service/*.go"
ARG GOMODPROXY

ENV CGO_ENABLED="0"
ENV GOPROXY=${GOMODPROXY}
ENV GOTARGET=${GOTARGET}

# Vendor first to we can user Docker caching layer
ONBUILD WORKDIR /repo
ONBUILD COPY go.mod .
ONBUILD COPY go.sum .

ONBUILD RUN go mod download

# The build script contains everything you need for building the service/ directory in your project.
COPY build.sh /build.sh

ONBUILD COPY . .
ONBUILD RUN /build.sh
