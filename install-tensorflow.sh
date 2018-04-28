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
curl https://bazel.build/bazel-release.pub.gpg | apt-key add -

apt-get update && apt-get install -y bazel
apt-get -y upgrade bazel

apt install -y python3 python3-dev python3-pip
pip install -y six numpy wheel

# protobuf
apt install -y libprotobuf-dev protobuf-compiler
