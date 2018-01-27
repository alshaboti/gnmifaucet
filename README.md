# gnmi for faucet
Utalize link022 gnmi server and anget to build an agnet for faucet.

You should install link022 and then follow instruction here. 

STEPS: 
- Install yang moduls,go,ygot prerequisits 
```
cd scripts
./install-yang-modules.sh
```
- - Replace ~/go/src/github.com/google/link022/agent/gnmi/handler.go with the existing one
- Compile simple-faucet-configuration.yang using generate-faucet-schem.sh script. It will aslo rebuild the faucet-agent
```
./generate-faucet-schem.sh
```
- run faucet-agent
```
sudo env PATH=$PATH  faucet_agent -ca=cert/server/ca.crt -cert=cert/server/server.crt -key=cert/server/server.key -eth_intf_name=eth0 -wlan_intf_name=wlan1 -gnmi_port=8080 -logtostderr
```
- Run gnmi_set (assume in the same host)
```
sudo env PATH=$PATH gnmi_set -ca=cert/client/ca.crt -cert=cert/client/client.crt -key=cert/client/client.key -target_name=www.example.com -target_addr=127.0.0.1:8080 -replace=/:@faucet-conf.json
```
# TODO:
- Remove all link022 params,files, and make a core gnmi agent for faucet you will need to update script folder scripts.
- Update yang module for faucet to build e.g. mirror/unmirror configuration
- Update the agent to confige faucet.yaml file.
