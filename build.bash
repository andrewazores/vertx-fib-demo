#!/usr/bin/env bash

set -xe

DIR="$(dirname "$(readlink -f "$0")")"

BUILD_IMG="${APP_REGISTRY:-quay.io}/${APP_NAMESPACE:-andrewazores}/${APP_NAME:-vertx-fib-demo}"
BUILD_TAG="${APP_VERSION:-$(sh "${DIR}/gradlew" -q printVersion)}"

podman manifest create "${BUILD_IMG}:${BUILD_TAG}"

for arch in amd64 arm64; do
    echo "Building for ${arch} ..."
    JIB_ARCH="${arch}" sh "${DIR}"/gradlew jibDockerBuild
    podman manifest add "${BUILD_IMG}:${BUILD_TAG}" containers-storage:"${BUILD_IMG}:linux-${arch}"
done

podman tag "${BUILD_IMG}:${BUILD_TAG}" "${BUILD_IMG}:latest"
