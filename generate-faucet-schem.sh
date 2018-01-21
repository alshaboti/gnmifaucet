# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Updated from https://github.com/boleifu/link022/blob/f0d51b843c4c0461393c8cbb467e599d99ed6989/openconfig/scripts/generate_wifi_oc_schema.sh

#!/bin/bash
#
# Generates the latest version of the OpenConfig textproto schema descriptor and
# model visualization from the source YANG modules.
#
# To use this, run thr scripts directory:
#    ./generate_wifi_oc_schema.sh

export GOPATH=$HOME/go

# Tools
# install it by : go get github.com/openconfig/ygot/generator
YANG_CONVERTER=$GOPATH/src/github.com/openconfig/ygot/generator/generator.go

# OpenConfig modules
# Download OpenConfig models from https://github.com/openconfig/public
# Download Yang moduels from https://github.com/YangModels/yang
YANG_MODELS=~/yangmodules/public/release/models,~/yangmodules/yang/experimental/ietf-extracted-YANG-modules
# Download ietf models from https://github.com/openconfig/yang/tree/master/standard/ietf/RFC, rename it to oc-yang
IETF_MODELS=~/yangmodules/oc-yang/standard/ietf/RFC
OWCA_TOP_MODULE=../models/openconfig-office-ap.yang
#IGNORED_MODULES=openconfig-wifi-phy,openconfig-wifi-mac,openconfig-system

# Output path
OUTPUT_PACKAGE_NAME=ocstruct
OUTPUT_FILE_PATH=../../generated/$OUTPUT_PACKAGE_NAME/$OUTPUT_PACKAGE_NAME.go

go run $YANG_CONVERTER \
-path=$YANG_MODELS,$IETF_MODELS \
-generate_fakeroot -fakeroot_name=device \
-package_name=ocstruct -compress_paths=false \
-output_file=$OUTPUT_FILE_PATH \
$OWCA_TOP_MODULE

#-exclude_modules=$IGNORED_MODULES \

