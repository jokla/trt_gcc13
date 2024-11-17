FROM nvidia/cuda:12.6.0-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y install tensorrt

RUN apt install gdb -y && apt clean
