# Alpine (golang)
This Docker image is used to build Go service projects on the LUSHDigital infrastructure. It is not supposed to be used to run images in production, but rather to serve as a an intermediary image in staged docker builds to produce artefacts.

## Examples
The image will build your projects with `-ldflags` setting two variables in your main package called `version` containing the very latest version tag of your tree and `revision` containing the current git commit hash.

```go
package main

import (
    "github.com/LUSHDigital/core"
)

var (
    version  string
    revision string
)

func main() {
    svc := &core.Service{
        Version: version,
    }
    svc.StartWorkers(context.Background())
}
```