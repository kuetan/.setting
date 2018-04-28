#!/bin/bash
# Patrick Wieschollek

# =============================================================
# UPDATE SOURCE
# =============================================================
git checkout -- .
git pull origin master


python_version = python3
tensorflow_version = 1.8.0

echo "build TensorFlow for Python version:", ${python_version}

# =============================================================
# CONFIGURATION
# =============================================================
TF_ROOT=/opt/tensorflow-${tensorflow_version}

cd $TF_ROOT

export PYTHON_BIN_PATH=$(which ${python_version})
export PYTHON_LIB_PATH="$($PYTHON_BIN_PATH -c 'import site; print(site.getsitepackages()[0])')"
export PYTHONPATH=${TF_ROOT}/lib
export PYTHON_ARG=${TF_ROOT}/lib
export CUDA_TOOLKIT_PATH=/usr/local/cuda
export CUDNN_INSTALL_PATH=/usr/local/cuda

export TF_NEED_GCP=0
export TF_NEED_CUDA=1
export TF_CUDA_VERSION="$($CUDA_TOOLKIT_PATH/bin/nvcc --version | sed -n 's/^.*release \(.*\),.*/\1/p')"
export TF_CUDA_COMPUTE_CAPABILITIES=61
export TF_NEED_HDFS=0
export TF_NEED_OPENCL=0
export TF_NEED_JEMALLOC=1
export TF_ENABLE_XLA=0
export TF_NEED_VERBS=0
export TF_CUDA_CLANG=0
export TF_CUDNN_VERSION="$(sed -n 's/^#define CUDNN_MAJOR\s*\(.*\).*/\1/p' $CUDNN_INSTALL_PATH/include/cudnn.h)"
export TF_NEED_MKL=0
export TF_DOWNLOAD_MKL=0
export TF_NEED_MPI=0

export GCC_HOST_COMPILER_PATH=$(which gcc)
export CC_OPT_FLAGS="-march=native"


# =============================================================
# BUILD NEW VERSION
# =============================================================
bazel clean
./configure

# build TensorFlow (add  -s to see executed commands)
# "--copt=" can be "-mavx -mavx2 -mfma  -msse4.2 -mfpmath=both"
# build entire package
bazel build  -c opt --copt=-mfpmath=both --copt=-msse4.2 --config=cuda //tensorflow/tools/pip_package:build_pip_package
# build c++ library
bazel build  -c opt --copt=-mfpmath=both --copt=-msse4.2 --config=cuda  tensorflow:libtensorflow_cc.so
# build TF pip package
bazel-bin/tensorflow/tools/pip_package/build_pip_package ${TF_ROOT}/pip/tensorflow_pkg
