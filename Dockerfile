# Requires 4.1 GB Internet to download it. 
FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND="noninteractive" TZ="Asia/Kolkata"

RUN apt update -y
RUN apt upgrade -y
RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt install net-tools -y
RUN apt install alsa-base -y
RUN apt install alsa-utils -y
RUN apt install libssl-dev -y
RUN apt install libffi-dev -y
RUN apt install libaom-dev -y
RUN apt install libunistring-dev -y
RUN apt install clang -y
RUN apt install build-essential -y
RUN apt install python3 -y
RUN apt install python3-pip -y
RUN apt install tzdata -y
RUN apt install sox -y
RUN apt install libasound-dev -y
RUN apt install libportaudio2 -y
RUN apt install libportaudiocpp0 -y
RUN apt install portaudio19-dev -y
RUN apt install ffmpeg -y
RUN apt install cmake -y
RUN apt install git -y
RUN apt install wget -y
RUN apt install libmagic-dev -y

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools
RUN python3 -m pip install --upgrade wheel
RUN python3 -m pip install --upgrade flask
RUN python3 -m pip install --upgrade pyaudio
RUN python3 -m pip install --upgrade pandas

RUN git clone https://github.com/parlance/ctcdecode.git

# 2 GB file next
RUN python3 -m pip install torch==1.9.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchvision==0.10.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchtext==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchmetrics==0.5.1 -f https://download.pytorch.org/whl/torch_stable.html

ENV CUDA_HOME /usr/local/cuda
RUN python3 -m pip install /ctcdecode/.

COPY requirements.txt /requirements.txt
RUN python3 -m pip install -r /requirements.txt

# RUN apt install nvidia-driver-460 -y
# RUN apt install nvidia-driver-465 -y
# ENTRYPOINT [ "nvidia-smi" ]

### Test Commands (Just for checking if versions are proper)
# working -> 3.8.10
# ENTRYPOINT [ "python3", "--version" ]

# working -> 11.1.105
# ENTRYPOINT [ "nvcc", "--version" ]

# working -> 20.0.2 (3.8)
# ENTRYPOINT [ "pip", "--version" ]

WORKDIR /

### For testing purpose create a test.py file and uncomment next 2 lines of code. 
# COPY test.py /test.py
# ENTRYPOINT [ "python3", "/test.py" ]

# Actual file to be runned for inference. 
ENTRYPOINT [ "python3", "/VoiceAssistant/speechrecognition/demo/demo.py" ]
EXPOSE 3000
