# gnmi for faucet
Utalize link022 gnmi server and anget to build an agnet for faucet.

You should install link022 and then follow instruction here. 

STEPS: 
- Install yang moduls,go,ygot,gnmi_set, gnmi_get prerequisites 
```
cd scripts
./install-prerequisite.sh
```
- Compile faucet-configuration.yang using generate-faucet-configuration.sh script. It will also rebuild the faucet_agent
```
./generate-faucet-configuration.sh
```
- run faucet_agent
```
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
sudo env PATH=$PATH faucet_agent -ca=cert/server/ca.crt -cert=cert/server/server.crt -key=cert/server/server.key  -gnmi_port=8080 -logtostderr
```
- Run gnmi_set (assume in the same host)
```
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
cd json
sudo env PATH=$PATH gnmi_set -ca=../cert/client/ca.crt -cert=../cert/client/client.crt -key=../cert/client/client.key -target_name=www.example.com -target_addr=192.168.11.5:8080 -replace=/:@faucet-configuration.json
```
# TODO:
- Remove all link022 params,files, and make a core gnmi agent for faucet you will need to update script folder scripts.
- Update the agent to config faucet.yaml file.
