#!/bin/bash
#Change the directory of the script to the yugabyte-operator directory
# cd "$(cd "$(dirname "$0")" && pwd)/yugabyte-operator"

export IMAGE=ghcr.io/nimbupaniai/yugabyte-operator:dev

# Build the Linux binary the Dockerfile will copy in
mkdir -p build/_output/bin
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o build/_output/bin/yugabyte-operator ./cmd/manager

# Build the image (use --platform if you're on Apple Silicon building for amd64 clusters)
docker build --platform=linux/amd64 -f build/Dockerfile -t "$IMAGE" .

# Push (if needed)
docker push "$IMAGE"