# Updated from https://github.com/boleifu/link022/blob/f0d51b843c4c0461393c8cbb467e599d99ed6989/openconfig/scripts/generate_wifi_oc_schema.sh
#!/bin/bash

export GOPATH=$HOME/go

# Tools
YANG_CONVERTER=$GOPATH/src/github.com/openconfig/ygot/generator/generator.go

# OpenConfig modules
# Download OpenConfig models from https://github.com/openconfig/public
YANG_MODELS=$HOME/yangmodules/public/release/models,$HOME/yangmodules/yang/experimental/ietf-extracted-YANG-modules
# Download ietf models from https://github.com/openconfig/yang/tree/master/standard/ietf/RFC
IETF_MODELS=$HOME/yangmodules/oc-yang/standard/ietf/RFC
OWCA_TOP_MODULE=../models/simple-faucet-configuration.yang

# Output path
OUTPUT_PACKAGE_NAME=ocstruct
OUTPUT_FILE_PATH=$HOME/go/src/github.com/google/link022/generated/$OUTPUT_PACKAGE_NAME/$OUTPUT_PACKAGE_NAME.go

# remove previouse compiled file
mv $HOME/go/src/github.com/google/link022/generated/$OUTPUT_PACKAGE_NAME/$OUTPUT_PACKAGE_NAME.go $HOME/go/src/github.com/google/link022/generated/$OUTPUT_PACKAGE_NAME/$OUTPUT_PACKAGE_NAME.go.bak

go run $YANG_CONVERTER \
-path=$YANG_MODELS,$IETF_MODELS \
-generate_fakeroot -fakeroot_name=device \
-package_name=ocstruct -compress_paths=false \
-output_file=$OUTPUT_FILE_PATH \
$OWCA_TOP_MODULE

env GOOS=linux GOARCH=arm CC=arm-linux-gnueabi-gcc go build -o $GOPATH/bin/faucet_agent agent/agent.go

