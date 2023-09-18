#!/bin/bash

cur_dir=$(pwd)

# Save the current directory
pushd .

cd ..

C_COMPILER="$HACO_CC_COMPILER"
CXX_COMPILER="$HACO_CXX_COMPILER"
CXX_FLAGS="$HACO_CXX_FLAGS"
C_FLAGS="$HACO_C_FLAGS"

mkdir -p build
cd build
make clean

if [ "$C_FLAGS" != "default" ]; then
    cmake -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_CXX_FLAGS_RELEASE="$CXX_FLAGS" \
        -D CMAKE_C_FLAGS_RELEASE="$C_FLAGS" \
        -D CMAKE_C_COMPILER="$C_COMPILER" \
        -D CMAKE_CXX_COMPILER="$CXX_COMPILER" \
        -D CMAKE_RULE_MESSAGES=OFF \
        -D CMAKE_VERBOSE_MAKEFILE=ON \
        ..
else
    cmake -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_C_COMPILER="$C_COMPILER" \
        -D CMAKE_CXX_COMPILER="$CXX_COMPILER" \
        -D CMAKE_RULE_MESSAGES=OFF \
        -D CMAKE_VERBOSE_MAKEFILE=ON \
        ..
fi

SANITIZED_FLAGS=$(echo "${C_FLAGS}" | tr -s '[:space:]' '_' | tr -d '=./' | tr '-' '_')

make -j32 gpt-2 gpt-j > "${cur_dir}/install_log/build_${SANITIZED_FLAGS}.log" 2>&1

if [ "$C_FLAGS" == "default" ]; then
    ../examples/gpt-j/download-ggml-model.sh 6B
fi
# Return to the original directory
popd
