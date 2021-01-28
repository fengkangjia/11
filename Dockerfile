FROM ubuntu:16.04

USER root

RUN sed -i 's/archive.ubuntu.com/mirrors.huaweicloud.com/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y  gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm g++ libstdc++6 lib32stdc++6 libpulse-dev rpm2cpio python3 vim bsdmainutils policycoreutils usbutils locales apt-utils cpio gnupg flex bison gperf build-essential zip curl zlib1g-dev g++-multilib x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc bc inetutils-ping python-pip libssl-dev filepp kmod

RUN apt-get install -y sudo

RUN apt-get install libxml-simple-perl

RUN useradd -u %(uid)d %(username)s -g sudo -s /bin/bash -m

RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
RUN echo "%(username)s:build" | chpasswd

RUN locale-gen en_US.UTF-8

USER %(username)s
WORKDIR /home/%(username)s/workspace
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV HOME /home/%(username)s
ENV CONTAINER_NAME Ubuntu_16.04

RUN echo "export PS1=\"[\u@$CONTAINER_NAME] \W\$ \"" >> ~/.bashrc
RUN echo "export USER=$(whoami)" >> ~/.bashrc
RUN echo "export USE_CCACHE=1" >> ~/.bashrc
RUN echo "export CCACHE_EXEC=/usr/bin/ccache" >> ~/.bashrc
RUN echo "export HEXAGON_ROOT=/opt/Qualcomm/Hexagon" >>~/.bashrc
RUN echo "export SHELL=/bin/bash" >>~/.bashrc

RUN git config --global user.email "build@megatronix.co"
RUN git config --global user.name "build"
