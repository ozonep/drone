#!/bin/sh

echo "building docker images for linux/amd64 ..."
# compile the server using the cgo
go build -ldflags "-extldflags \"-static\"" -o release/linux/amd64/drone-server github.com/ozonep/drone/cmd/drone-server
