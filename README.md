# gnmifaucet
Utalize link022 gnmi server and anget to build an agnet for faucet.

You should install link022 and then follow instruction here. 

STEPS: 
- Install yang moduls using install-yang-modules.sh script
- Compile faucet-configuration.yang using generate-faucet-schem.sh script
- Replace ~/go/src/github.com/google/link022/agent/gnmi/handler.go
- rebuild agent using ./build.sh script
- run the agent, and use gnmi_set with simple .json file with "hostname":"xyz", handler will only receive the file and save it. 

# ToDo
add acl entry using these two moduls:
https://github.com/YangModels/yang/blob/master/experimental/ietf-extracted-YANG-modules/ietf-packet-fields%402017-10-03.yang
https://github.com/YangModels/yang/blob/master/experimental/ietf-extracted-YANG-modules/ietf-access-control-list%402017-10-03.yang

# last step
After compile faucet-configuration.yang, and build agent.go
```
module faucet-configuration {

  yang-version "1";

  // namespace
  namespace "http://github.com/faucet";

  prefix "faucet-conf";

  import ietf-inet-types {
    prefix "inet";
  }

 import ietf-packet-fields {
    prefix packet-fields;
  }

  // meta
  organization "none";

  contact
    "none";

  description
    "This module defines the top level faucet conf.";

  revision "2017-12-04" {
    description
      "Initial version";
    reference "0.1.0";
  }

  grouping faucet-top {
    description
      "Top-level grouping for faucet conf.";

    leaf hostname {
      type inet:host;
      description
        "host";
    }
  container ipv4-acl {
      uses packet-fields:acl-ip-header-fields;
      uses packet-fields:acl-ipv4-header-fields;
      description
           "Rule set that supports IPv4 headers.";
      }
  }

  uses faucet-top;
}

```
Try to set using 
```
{
  "hostname":"raspberrypi",
  "ipv4-acl":{
   "protocol": "111"
  }
}

```
get error:
```
F0121 22:30:19.558646    2294 gnmi_set.go:158] Set failed: rpc error: code = InvalidArgument desc = unmarshaling json data to config struct fails: parent container device (type *ocstruct.Device): JSON contains unexpected field ipv4-acl
```
