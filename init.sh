#!/bin/bash

RELEASE=$(lsb_release -rs)
OS="$(echo $(lsb_release -is) | tr '[A-Z]' '[a-z]')"
CODENAME=$(lsb_release -cs)
echo "OS: $OS, release of $RELEASE, code name: $CODENAME"

# vim
cat basic.vim > ~/.vimrc

# tsinghua tuna as ubuntu source
sudo cp /etc/apt/sources.list /etc/apt/sources.list.save
sudo cp sources.list /etc/apt/sources.list
sudo sed -i -e "s/{OS}/$OS/g" -e "s/{CODENAME}/$CODENAME/g" /etc/apt/sources.list

# node 10x
sudo cp sources.list.d/nodesource.list /etc/apt/sources.list.d/nodesource.list
sudo sed -i -e "s/{OS}/$OS/g" -e "s/{CODENAME}/$CODENAME/g" /etc/apt/sources.list.d/nodesource.list

# docker-ce
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# nivida-container
DIST=$(. /etc/os-release; echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | sudo apt-key add -

# nvidia-container-runtime
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -

# nvidia-docker
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$DIST/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# update essentials
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
	make \
    build-essential \
    vim \
    curl \
    libssl-dev \
    git \
	wget \
	python-pip \
	python-dev \
	python-virtualenv \
    docker-ce
