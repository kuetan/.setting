#!/usr/bin/env bash
# install bazel
#apt-get install pkg-config zip g++ zlib1g-dev unzip
#wget https://github.com/bazelbuild/bazel/releases/download/0.12.0/bazel-0.12.0-installer-linux-x86_64.sh
#chmod u+x bazel-0.12.0-installer-linux-x86_64.sh
#./bazel-0.12.0-installer-linux-x86_64.sh --user
#export PATH="$PATH:$HOME/bin"

apt-get install -y openjdk-8-jdk
add-apt-repository ppa:webupd8team/java -y
apt-get update && sudo apt-get install -y oracle-java8-installer
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -

apt-get update && apt-get install -y bazel
apt-get upgrade bazel

apt install python3 python3-dev python3-pip
pip install six numpy wheel

# protobuf
apt-get install libprotobuf-dev protobuf-compiler

# install tensorflow
VERSION=1.8.0
wget https://github.com/tensorflow/tensorflow/archive/v${VERSION}.tar.gz /opt/

echo "build TensorFlow for Python version:", ${python_version}

# =============================================================
# CONFIGURATION
# =============================================================
TF_ROOT=/opt/tensorflow-${VERSION}
cd $TF_ROOT

export PYTHON_BIN_PATH=$(which python)
export PYTHON_LIB_PATH="$($PYTHON_BIN_PATH -c 'import site; print(site.getsitepackages()[0])')"
export PYTHONPATH=${TF_ROOT}/lib
export PYTHON_ARG=${TF_ROOT}/lib
export CUDA_TOOLKIT_PATH=/usr/local/cuda
export CUDNN_INSTALL_PATH=/usr/local/cuda

export TF_NEED_GCP=0
export TF_NEED_CUDA=1
export TF_CUDA_VERSION="$($CUDA_TOOLKIT_PATH/bin/nvcc --version | sed -n 's/^.*release \(.*\),.*/\1/p')"
#export TF_CUDA_COMPUTE_CAPABILITIES=6.1,5.2,3.5
export TF_NEED_HDFS=0
export TF_NEED_OPENCL=0
export TF_NEED_JEMALLOC=0
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
