
#!/bin/bash
#
# Generates the latest version of the OpenConfig textproto schema descriptor and
# model visualization from the source YANG modules.
#
# To use this, run thr scripts directory:
#    ./generate_wifi_oc_schema.sh

export GOPATH=$HOME/go

# Tools
YANG_CONVERTER=$GOPATH/src/github.com/openconfig/ygot/generator/generator.go

# OpenConfig modules
# Download OpenConfig models from https://github.com/openconfig/public
YANG_MODELS=$HOME/yangmodules/yang/experimental/ietf-extracted-YANG-modules/
#,~/yangmodules/public/release/models/
# Download ietf models from https://github.com/openconfig/yang/tree/master/standard/ietf/RFC
IETF_MODELS=$HOME/yangmodules/oc-yang/standard/ietf/RFC/
OWCA_TOP_MODULE=../modules/faucet-configuration.yang #ietf-mud@2017-10-07.yang
#IGNORED_MODULES=openconfig-wifi-phy,openconfig-wifi-mac,openconfig-system

# Output path
OUTPUT_PACKAGE_NAME=ocstruct
OUTPUT_FILE_PATH=$HOME/go/src/github.com/alshaboti/gnmifaucet/generated/$OUTPUT_PACKAGE_NAME/$OUTPUT_PACKAGE_NAME.go

go run $YANG_CONVERTER \
-path=$YANG_MODELS,$IETF_MODELS \
-generate_fakeroot -fakeroot_name=device \
-package_name=ocstruct -compress_paths=false \
-output_file=$OUTPUT_FILE_PATH \
$OWCA_TOP_MODULE

echo "Yang is compiled to .go file!"
#-exclude_modules=$IGNORED_MODULES \
#for ubuntu
env GOOS=linux GOARCH=amd64 go build -o $GOPATH/bin/faucet_agent  ../faucet_agent/agent.go

#for pi
#env GOOS=linux GOARCH=arm CC=arm-linux-gnueabi-gcc go build -o $GOPATH/bin/faucet_agent  ../faucet_agent/agent.go
#$HOME/link022/agent/agent.go

echo ".go file and agent.go compiled  to binary file !"

#run faucet_agent using 
#sudo env PATH=$PATH faucet_agent -ca=link022/demo/cert/server/ca.crt -cert=link022/demo/cert/server/server.crt -key=link022/demo/cert/server/server.key  -gnmi_port=8080 -logtostderr
#and gnmi_set using 
# sudo env PATH=$PATH gnmi_set -ca=cert/client/ca.crt -cert=cert/client/client.crt -key=cert/client/client.key -target_name=www.example.com -target_addr=192.168.11.5:8080 -replace=/:@faucet-configuration.json
