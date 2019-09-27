# Alpine (golang)
This Docker image is used to build Go service projects on the LUSHDigital infrastructure. It is not supposed to be used to run images in production, but rather to serve as a an intermediary image in staged docker builds to produce artefacts.

## Setting up your project Dockerfile
Since we don't need to have the entire Go toolchain in our production images, we can take the build artefacts from the first build stage and put them in another.

```Dockerfile
FROM lushdigital/alpine-golang:latest
FROM alpine:latest
# Copy from the first stage of the build process
COPY --from=0 /repo/build build
RUN ["build/service"]
```

## Using build variables in your Go code
The image will build your projects with `-ldflags` setting two variables in your main package called `tag` containing the very latest version tag of your tree and `ref` containing the current git commit hash.

```go
package main

var (
    tag  string
    ref string
)

func main() {
    ...
}
```

## Using build variables in the LUSHDigital/core package
This package will also use the build flags to interpolate the commit hash and latest version tag straight into the [LUSHDigital/core](https://github.com/LUSHDigital/core) package.

```go
package main

import (
    "github.com/LUSHDigital/core"
)

func main() {
    // The service struct will now automatically contain the commit hash and latest version tag derived from the build flags.
    service := core.NewService("example", "service")
    ...
}
```