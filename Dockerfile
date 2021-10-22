# Requires 4.1 GB Internet to download it. 
FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04

# Requires 2.3 GB Internet to download it. 
# FROM nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND="noninteractive" TZ="Asia/Kolkata"
ENV CUDA_HOME /usr/local/cuda

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
RUN apt install nvidia-driver-465 -y
RUN apt install openjdk-8-jre-headless -y
RUN apt install nvidia-cuda-toolkit -y

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools
RUN python3 -m pip install --upgrade wheel
RUN python3 -m pip install --upgrade flask
RUN python3 -m pip install --upgrade pandas
RUN python3 -m pip install --upgrade pyaudio

WORKDIR /

# 2 GB file next, requires good internet for the below command. 
# RUN python3 -m pip install torch==1.9.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html

## alternative option for above command
RUN wget https://download.pytorch.org/whl/cu111/torch-1.9.1%2Bcu111-cp38-cp38-linux_x86_64.whl

## ELSE download the file on local system and copy to docker file system. 
# COPY torch-1.9.1+cu111-cp38-cp38-linux_x86_64.whl torch-1.9.1+cu111-cp38-cp38-linux_x86_64.whl

# below commands will be same for downloading with wget or copying from local system
RUN pip install torch-1.9.1+cu111-cp38-cp38-linux_x86_64.whl
RUN rm torch-1.9.1+cu111-cp38-cp38-linux_x86_64.whl

RUN python3 -m pip install torchvision==0.10.1+cu111 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchtext==0.10.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3 -m pip install torchmetrics==0.5.1 -f https://download.pytorch.org/whl/torch_stable.html

COPY VoiceAssistant/ /VoiceAssistant/
COPY requirements.txt requirements.txt

RUN git clone --recursive https://github.com/parlance/ctcdecode.git
RUN python3 -m pip install /ctcdecode/.

# RUN python3 -m pip install -r requirements.txt

# ENTRYPOINT [ "nvidia-smi" ]

# working -> 3.8.10
# ENTRYPOINT [ "python3", "--version" ]

# working -> 11.1.105
# ENTRYPOINT [ "nvcc", "--version" ]

# working -> 20.0.2 (3.8)
# ENTRYPOINT [ "pip", "--version" ]

# CMD [ "pip", "freeze", ">>", "/new_requirements.txt" ]
# ENTRYPOINT [ "pip", "freeze" ]

ENTRYPOINT [ "python3", "/VoiceAssistant/speechrecognition/demo/demo.py" ]
EXPOSE 3000

# COPY test.py /test.py
# ENTRYPOINT [ "python3", "/test.py" ]
# ENTRYPOINT [ "nvidia-smi" ]
