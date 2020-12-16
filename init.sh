#!/bin/bash

# vim
cat basic.vim > ~/.vimrc

# ubuntu sources
sudo cp /etc/apt/sources.list /etc/apt/sources.list.save
sudo cp sources.list /etc/apt/sources.list
sudo mv /etc/apt/sources.list.d /etc/apt/sources.list.d.save
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
