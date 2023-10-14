# Start with a base Debian image
FROM ubuntu:22.04 AS base

# Install necessary tools and libraries including Qt5 and CMake
RUN apt-get update; \
    apt-get upgrade -y;  \
    apt-get install -y \
    build-essential \
    cmake \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN \
apt-get update; \
apt-get -y install --fix-missing \
qtbase5-dev \
qtdeclarative5-dev \
libqt5serialport5-dev \
qml-module-qtquick-layouts \
qml-module-qtquick-controls \
qtquickcontrols2-5-dev \
qml-module-qtgraphicaleffects \
qml-module-qttest 

