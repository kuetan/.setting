#!/bin/bash -eu
# -*- coding: utf-8 -*-

HEADER_DIR=/tmp/tensorflow/include

if [ ! -e $HEADER_DIR ];
then
    mkdir -p $HEADER_DIR
fi

find tensorflow/core -follow -type f -name "*.h" -exec cp --parents {} $HEADER_DIR \;
find tensorflow/cc   -follow -type f -name "*.h" -exec cp --parents {} $HEADER_DIR \;
find tensorflow/c    -follow -type f -name "*.h" -exec cp --parents {} $HEADER_DIR \;

find third_party/eigen3 -follow -type f -exec cp --parents {} $HEADER_DIR \;
pwd
cd bazel-genfiles
find tensorflow -follow -type f -name "*.h" -exec cp --parents {} $HEADER_DIR \;
cd ..

pushd bazel-tensorflow/external/protobuf/src
find google -follow -type f -name "*.h" -exec cp --parents {} $HEADER_DIR \;
popd

pushd bazel-tensorflow/external/eigen_archive
find Eigen       -follow -type f -exec cp --parents {} $HEADER_DIR \;
find unsupported -follow -type f -exec cp --parents {} $HEADER_DIR \;
popd
