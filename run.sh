#!/bin/sh

set -x
set -e

ARGS=(--name vertx-fib-demo -p $HTTP_PORT -p 9093:9093)

if podman pod exists container-jfr; then
    ARGS+=(--pod container-jfr)
fi

ARGS+=(--rm -it quay.io/andrewazores/vertx-fib-demo:latest)

podman run "${ARGS[@]}"
