#!/bin/sh

set -x
set -e

if [ -z "$HTTP_PORT" ]; then
    HTTP_PORT=8080
fi

ARGS=(--name vertx-fib-demo -p $HTTP_PORT:$HTTP_PORT -p 9093:9093)

if podman pod exists cryostat; then
    ARGS+=(--pod cryostat)
fi

ARGS+=(--env HTTP_PORT="$HTTP_PORT")
ARGS+=(--rm -it quay.io/andrewazores/vertx-fib-demo:latest)

podman run "${ARGS[@]}"
