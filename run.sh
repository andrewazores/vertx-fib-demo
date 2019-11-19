#!/bin/sh

set -x

function cleanup() {
    set +e
    # TODO: better container management
    docker kill $(docker ps -a -q --filter ancestor=quay.io/andrewazores/vertx-fib-demo)
    docker rm $(docker ps -a -q --filter ancestor=quay.io/andrewazores/vertx-fib-demo)
}

cleanup
trap cleanup EXIT

set -e

docker run \
    -p 8080:8080 \
    --net container-jfr \
    --hostname vertx-fib-demo \
    --name vertx-fib-demo \
    --memory 256M \
    --cpus 0.5 \
    --rm -it quay.io/andrewazores/vertx-fib-demo:latest "$@"
