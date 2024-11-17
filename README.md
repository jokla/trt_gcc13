# Instructions

## Onnx to TRT conversion - issue with gcc 13

### tensorrt:24.10-py3, with default gcc - working
```bash
docker run --gpus all -it --rm  -v ./data:/data nvcr.io/nvidia/tensorrt:24.10-py3 /usr/bin/bash -c "trtexec --onnx=/data/yolov8n.onnx --fp16 --verbose"
```

### tensorrt:24.10-py3 + gcc 13 - not working

- Build the docker image
```bash
docker build -f trt_24_10_gcc13.dockerfile -t trt_24_10_gcc13 .
```
- Run the conversion

```bash
docker run --gpus all -it --rm  -v ./data:/data trt_24_10_gcc13 bash -c "gdb -ex run -ex bt --args trtexec --onnx=/data/yolov8n.onnx --fp16 --verbose"
```

```bash
[11/16/2024-19:45:37] [V] [TRT] /model.2/m.0/cv2/conv/Conv + PWN(PWN(PWN(/model.2/m.0/cv2/act/Sigmoid), PWN(/model.2/m.0/cv2/act/Mul)), PWN(/model.2/m.0/Add)) (CaskConvolution[0x80000009]) profiling completed in 0.541964 seconds. Fastest Tactic: 0x29d52f76d7883502 Time: 0.00956038

Thread 1 "trtexec" received signal SIGSEGV, Segmentation fault.
0x000073a1377de16e in ?? () from /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#0  0x000073a1377de16e in ?? () from /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#1  0x000073a1377ded5a in _Unwind_Find_FDE () from /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#2  0x000073a1377da60a in ?? () from /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#3  0x000073a1377dc07d in _Unwind_RaiseException () from /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
#4  0x000073a13798605b in __cxa_throw () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x000073a0fc4b214e in ?? () from /usr/lib/x86_64-linux-gnu/libnvinfer.so.10
#6  0x000073a0fc513259 in ?? () from /usr/lib/x86_64-linux-gnu/libnvinfer.so.10
```


### tensorrt:24.10-py3 + gcc 13 + TRT 10.6.0  - not working

- Build docker image
```bash
docker build -f trt_10_6_24_10_gcc13.dockerfile -t trt_10_6_24_10_gcc13 .
```
- Run the conversion

```bash
docker run --gpus all -it --rm  -v ./data:/data trt_10_6_24_10_gcc13 /usr/bin/bash -c "gdb -ex run -ex bt --args trtexec --onnx=/data/yolov8n.onnx --fp16 --verbose"
```


## Trtexec with parameter

- Trtexec is also crashing when I run it with an incorrect parameter:
```bash
docker run --gpus all -it --rm  trt_24_10_gcc13 /usr/bin/bash -c "trtexec --test && pwd"
```

```bash
docker run --gpus all -it --rm  trt_10_6_24_10_gcc13 /usr/bin/bash -c "trtexec --test && pwd"
```


- The command is working just fine with the default GCC compiler
```bash
docker run --gpus all -it --rm  nvcr.io/nvidia/tensorrt:24.10-py3 /usr/bin/bash -c "trtexec --test"
```
