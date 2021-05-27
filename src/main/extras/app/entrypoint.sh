#!/bin/sh

set -x
set -e

if [ -z "$HTTP_PORT" ]; then
    HTTP_PORT=8080
fi

if [ -z "$JMX_PORT" ]; then
    JMX_PORT=9093
fi

FLAGS=(
    "-XX:+CrashOnOutOfMemoryError"
    "-Dcom.sun.management.jmxremote.autodiscovery=true"
    "-Dcom.sun.management.jmxremote.port=$JMX_PORT"
    "-Dcom.sun.management.jmxremote.rmi.port=$JMX_PORT"
    "-Dcom.sun.management.jmxremote.ssl.need.client.auth=false"
)

if [ -z "$HOSTNAME" ]; then
    FLAGS+=("-Djava.rmi.server.hostname=$HOSTNAME")
fi

if [ ! -z "$USE_SSL" ]; then
    FLAGS+=("-Dcom.sun.management.jmxremote.ssl=true")
    FLAGS+=("-Dcom.sun.management.jmxremote.registry.ssl=true")
    FLAGS+=("-Djavax.net.ssl.keyStore=/app/resources/keystore")
    FLAGS+=("-Djavax.net.ssl.keyStorePassword=vertx-fib-demo")
else
    FLAGS+=("-Dcom.sun.management.jmxremote.ssl=false")
    FLAGS+=("-Dcom.sun.management.jmxremote.registry.ssl=false")
fi

if [ ! -z "$USE_AUTH" ]; then
    FLAGS+=("-Dcom.sun.management.jmxremote.authenticate=true")
    FLAGS+=("-Dcom.sun.management.jmxremote.password.file=/app/resources/jmxremote.password")
    FLAGS+=("-Dcom.sun.management.jmxremote.access.file=/app/resources/jmxremote.access")
else
    FLAGS+=("-Dcom.sun.management.jmxremote.authenticate=false")
fi

java \
    "${FLAGS[@]}" \
    -cp /app/resources:/app/classes:/app/libs/* \
    es.andrewazor.demo.Main \
    "$@"
