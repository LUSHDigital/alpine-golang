FROM golang:1-alpine
RUN apk add git

ONBUILD WORKDIR /repo
ONBUILD COPY . .
ONBUILD RUN go build \
    -o build/service \
    -mod=vendor \
    -ldflags "-X main.revision=$(git rev-parse --verify HEAD)" \
    service/*.go
