#!/bin/sh

set -x
set -e

if [ -z "$HTTP_PORT" ]; then
    HTTP_PORT=8080
fi

ARGS=(--name vertx-fib-demo -p $HTTP_PORT:$HTTP_PORT -p 9093:9093)

if podman pod exists container-jfr; then
    ARGS+=(--pod container-jfr)
fi

ARGS+=(--rm -it quay.io/andrewazores/vertx-fib-demo:latest)
ARGS+=(--env HTTP_PORT="$HTTP_PORT")

podman run "${ARGS[@]}"
