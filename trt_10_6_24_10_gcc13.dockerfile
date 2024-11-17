FROM trt_24_10_gcc13

ENV DEBIAN_FRONTEND=noninteractive

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
RUN dpkg -i cuda-keyring_1.1-1_all.deb
RUN apt-get update && apt-get -y install cuda-toolkit-12-6
RUN apt-get -y install tensorrt
