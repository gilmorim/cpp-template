FROM ubuntu:devel

ARG USERNAME=ubuntu
ARG USER_HOME=/home/$USERNAME

ENV DEBIAN_FRONTEND=noninteractive

RUN /usr/bin/bash -c "apt update && apt upgrade -y && apt-get autoremove && apt-get autoclean" && \
    apt-get -y install vim git wget curl build-essential manpages-dev software-properties-common gcc-11 g++-11 gdb \
    cmake doxygen llvm pkg-config zip unzip tar clang-format clang-tidy && \
    apt-get -y install python3.10 python3-pip virtualenvwrapper

USER $USERNAME
WORKDIR $USER_HOME
