#!/bin/bash
#
# Generates the latest version of the OpenConfig textproto schema descriptor and
# model visualization from the source YANG modules.
#
# To use this, run thr scripts directory:
#    ./install-yang-modules.sh

<<<<<<< HEAD
#install go
wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
#go1.7.linux-armv6l.tar.gz
sudo tar -C /usr/local -xzf go1.7.linux-amd64.tar.gz
#go1.7.linux-armv6l.tar.gz go1.2.1.linux-amd64.tar.gz
=======
#install go 
#for pi
wget https://storage.googleapis.com/golang/go1.7.linux-armv6l.tar.gz
sudo tar -C /usr/local -xzf go1.7.linux-armv6l.tar.gz
# for linux
# wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
# sudo tar -C /usr/local -xzf go1.7.linux-amd64.tar.gz

>>>>>>> 708fca7c47690badbd7135f453c17fbd4d13e4ba
export PATH=$PATH:/usr/local/go/bin

# OpenConfig modules
# Download OpenConfig models from 
cd ~
mkdir yangmodules
cd yangmodules
# OpenConfig modules
git clone https://github.com/openconfig/public
# Download Yang moduels from 
git clone https://github.com/YangModels/yang
# Download ietf models
git clone https://github.com/openconfig/yang oc-yang

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin

# Tools for compiling yang to .go (ygot)
 go get github.com/openconfig/ygot/generatorexport 
 
 go get github.com/google/gnxi/gnmi_set
 go get github.com/google/gnxi/gnmi_get
 
 
