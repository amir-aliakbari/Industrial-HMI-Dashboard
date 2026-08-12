#!/usr/bin/env bash
set -e

BUILD_DIR="build"

if ! command -v cmake >/dev/null 2>&1; then
    echo "cmake is required but not installed." >&2
    exit 1
fi

cmake -S . -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=Release
cmake --build "$BUILD_DIR" -j"$(nproc 2>/dev/null || echo 4)"

echo "Build finished. Run with: ./$BUILD_DIR/IndustrialHmiDashboard"
