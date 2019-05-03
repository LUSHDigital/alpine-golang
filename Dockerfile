FROM golang:1-alpine
RUN apk add git

# The build script contains everything you need for building the service/ directory in your project.
COPY build.sh /build.sh

ONBUILD WORKDIR /repo
ONBUILD COPY . .
ONBUILD RUN /build.sh
