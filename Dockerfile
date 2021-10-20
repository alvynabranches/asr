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

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools
RUN python3 -m pip install --upgrade wheel

# 2 GB file next
RUN python3 -m pip install torch==1.9.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchvision==0.10.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchtext==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchmetrics==0.5.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install -r requirements.txt

# RUN apt install nvidia-driver-460 -y
# RUN apt install nvidia-driver-465 -y
# ENTRYPOINT [ "nvidia-smi" ]

RUN apt install git

WORKDIR /
RUN git clone https://github.com/parlance/ctcdecode.git
RUN pip install /VoiceAssistant/VoiceAssistant/ctcdecode/.

# ENTRYPOINT [ "pip", "freeze" ]
ENTRYPOINT [ "python3", "speechrecognition/demo/demo.py" ]

EXPOSE 3000
