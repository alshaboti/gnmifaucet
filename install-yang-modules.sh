#!/bin/bash
#
# Generates the latest version of the OpenConfig textproto schema descriptor and
# model visualization from the source YANG modules.
#
# To use this, run thr scripts directory:
#    ./install-yang-modules.sh

# OpenConfig modules
# Download OpenConfig models from 
cd ~
mkdir yangmodules
# OpenConfig modules
git clone https://github.com/openconfig/public
# Download Yang moduels from 
git clone https://github.com/YangModels/yang
# Download ietf models
git clone https://github.com/openconfig/yang oc-yang
