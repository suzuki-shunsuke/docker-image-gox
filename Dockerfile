FROM golang:1.12.1 AS go-build-env
# Unfortunately gox's binary isn't released so build it
RUN go get github.com/mitchellh/gox

FROM alpine:3.9
COPY --from=go-build-env /go/bin/gox /usr/local/bin/
RUN \
    apk add --no-cache ca-certificates  && \
    mkdir /lib64 && \
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
    rm -rf /var/cache/apk/*
