#!/bin/sh

set -x
set -e

FLAGS=(
    "-XX:+CrashOnOutOfMemoryError"
    "-Dcom.sun.management.jmxremote.autodiscovery=true"
    "-Dcom.sun.management.jmxremote.port=9093"
    "-Dcom.sun.management.jmxremote.rmi.port=9093"
    "-Dcom.sun.management.jmxremote.authenticate=true"
    "-Dcom.sun.management.jmxremote.password.file=/app/resources/jmxremote.password"
    "-Dcom.sun.management.jmxremote.access.file=/app/resources/jmxremote.access"
    "-Dcom.sun.management.jmxremote.ssl=true"
    "-Dcom.sun.management.jmxremote.registry.ssl=true"
    "-Dcom.sun.management.jmxremote.ssl.need.client.auth=false"
    "-Djavax.net.ssl.keyStore=/app/resources/keystore"
    "-Djavax.net.ssl.keyStorePassword=vertx-fib-demo"
)

java \
    "${FLAGS[@]}" \
    -cp /app/resources:/app/classes:/app/libs/* \
    es.andrewazor.demo.Main \
    "$@"
