On the server side run:

```
./generate-ocstruct.sh
sudo env PATH=$PATH GOPATH=$GOPATH go run link022/agent/agent.go -ca=link022/demo/cert/server/ca.crt -cert=link022/demo/cert/server/server.crt -key=link022/demo/cert/server/server.key -eth_intf_name=eth0 -wlan_intf_name=wlan1 -gnmi_port=8080 -logtostderr
```

On the client side run:
```
sudo env PATH=$PATH gnmi_set -ca=cert/client/ca.crt -cert=cert/client/client.crt -key=cert/client/client.key -target_name=www.example.com -target_addr=192.168.11.5:8080 -replace=/:@faucet-conf.json
```
