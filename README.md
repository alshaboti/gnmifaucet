# gnmi agent for faucet configuration
Gnmi agent allows you to configure faucet.yaml file remotely without SSH to faucet host. It use gnmi to replace/update faucet.yaml file. 

Project still in development stage. 
To test it follow the steps below: 

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
sudo env PATH=$PATH gnmi_set -ca=../cert/client/ca.crt -cert=../cert/client/client.crt -key=../cert/client/client.key -target_name=www.example.com -target_addr=<ip>:8080 -replace=/:@faucet-configuration.json
```
# TODO:
- create faucet.yaml file based on the received json file. 
- update faucet.yaml file based on the gnmi_set update command. 
