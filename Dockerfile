# alpine can't be used
# go: missing Git command. See https://golang.org/s/gogetcmd
# package github.com/mitchellh/gox: exec: "git": executable file not found in $PATH
FROM golang:1.12.9 AS go-build-env
# Unfortunately gox's binary isn't released so build it
RUN CGO_ENABLED=0 go get github.com/mitchellh/gox

FROM golang:1.12.9-alpine3.9
COPY --from=go-build-env /go/bin/gox /usr/local/bin/
RUN \
    apk add --no-cache ca-certificates  && \
    rm -rf /var/cache/apk/*
