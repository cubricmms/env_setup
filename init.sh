#!/bin/bash

RELEASE=$(lsb_release -rs)
OS="$(echo $(lsb_release -is) | tr '[A-Z]' '[a-z]')"
CODENAME=$(lsb_release -cs)
echo "OS: $OS, release of $RELEASE, code name: $CODENAME"

# vim
cat basic.vim > ~/.vimrc

# ubuntu sources
sudo cp /etc/apt/sources.list /etc/apt/sources.list.save
sudo cp sources.list /etc/apt/sources.list
sudo sed -i -e "s/{OS}/$OS/g" -e "s/{CODENAME}/$CODENAME/g" /etc/apt/sources.list
sudo rm -rf /etc/apt/sources.list.d.save &&  sudo mv /etc/apt/sources.list.d /etc/apt/sources.list.d.save
sudo cp -R sources.list.d /etc/apt/sources.list.d

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
	python-virtualenv
