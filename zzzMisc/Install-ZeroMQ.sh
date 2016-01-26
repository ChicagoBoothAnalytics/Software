#!/bin/bash


# install LibSodium
curl https://download.libsodium.org/libsodium/releases/LATEST.tar.gz --output LibSodium.tar.gz
tar xzf LibSodium.tar.gz
rm LibSodium.tar.gz
cd libsodium-*
./configure --prefix=/usr
make
make install
cd ..
rm -r libsodium-*


export sodium_CFLAGS=-I/usr/include
export sodium_LIBS=-L/usr/lib
export LDFLAGS=-lsodium
export LD_RUN_PATH=/usr/lib64:/usr/lib


# install ZeroMQ
git clone https://github.com/zeromq/libzmq
cd libzmq
./autogen.sh
./configure --prefix=/usr
make
make install
cd ..
rm -r libzmq
