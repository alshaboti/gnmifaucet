# based on https://github.com/openconfig/ygot/issues/150 issue
#!/bin/bash

export GOPATH=$HOME/go

# Tools
YANG_CONVERTER=$GOPATH/src/github.com/openconfig/ygot/generator/generator.go

# OpenConfig modules
# Download OpenConfig models from https://github.com/openconfig/public
# YANG_MODELS=$HOME/yangmodules/public/release/models
# download experimental yang from  https://github.com/YangModels/yang/tree/master/experimental/ietf-extracted-YANG-modules
EXPERIMENTAL_YANG_MODELS=$HOME/yangmodules/yang/experimental/ietf-extracted-YANG-modules
# Download ietf models from https://github.com/openconfig/yang/tree/master/standard/ietf/RFC
IETF_MODELS=$HOME/yangmodules/oc-yang/standard/ietf/RFC

OWCA_TOP_MODULE=faucet-test.yang

# Output path
OUTPUT_PACKAGE_NAME=oc
OUTPUT_FILE_PATH=$OUTPUT_PACKAGE_NAME/$OUTPUT_PACKAGE_NAME.go

# remove previouse compiled file
mv $GOPATH/src/$OUTPUT_FILE_PATH $GOPATH/src/$OUTPUT_FILE_PATH.bak

go run $YANG_CONVERTER \
-path=$IETF_MODELS,$EXPERIMENTAL_YANG_MODELS \
-generate_fakeroot  -fakeroot_name=device \
-package_name=$OUTPUT_PACKAGE_NAME  -compress_paths=false \
-output_file=$GOPATH/src/$OUTPUT_FILE_PATH \
$OWCA_TOP_MODULE

#run faucet test.
go run faucet-test.go
