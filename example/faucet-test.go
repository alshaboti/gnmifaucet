package main

import (
        "fmt"

        "oc"
        "github.com/kylelemons/godebug/pretty"
)

func main() {

        x := &oc.Device{}
        err := oc.Unmarshal([]byte(`{
  "hostname":"raspberrypi",
  "ipv4-acl":{
   "destination-ipv4-network": "192.168.1.0/24",
   "source-ipv4-network": "192.168.2.0/24"
  }
}`), x)

        if err != nil {
                panic(err)
        }

        fmt.Printf("%v\n", pretty.Sprint(x))
}
