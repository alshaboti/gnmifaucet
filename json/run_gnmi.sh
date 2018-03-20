#!/bin/bash
sudo env PATH=/home/shab/bin:/home/shab/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/usr/local/go/bin:/usr/local/go/bin:/home/shab/go/bin gnmi_set -ca=../cert/client/ca.crt -cert=../cert/client/client.crt -key=../cert/client/client.key -target_name=www.example.com -target_addr=192.168.3.10:8080 -replace=/:@simple-faucet-configuration.json


