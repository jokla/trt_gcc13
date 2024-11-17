FROM nvcr.io/nvidia/tensorrt:24.10-py3 AS base

ENV DEBIAN_FRONTEND=noninteractive

ARG GCC_VERSION=13
RUN apt update && apt install software-properties-common -y && add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt update && apt install g++-"$GCC_VERSION" gcc-"$GCC_VERSION" -y && apt clean
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-"$GCC_VERSION" "$GCC_VERSION" \
    --slave /usr/bin/g++ g++ /usr/bin/g++-"$GCC_VERSION" \
    --slave /usr/bin/gcov gcov /usr/bin/gcov-"$GCC_VERSION"

RUN apt install gdb -y && apt clean
