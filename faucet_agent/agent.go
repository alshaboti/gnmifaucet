/* Copyright 2017 Google Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// The agent program is the link022 AP agent.
// It converts the target device to an Link022 AP and runs in the background as
// a management daemon.
package main

import (
	"flag"
	"fmt"
	"net"
	"os"

	"github.com/google/gnxi/utils/credentials"
	"github.com/alshaboti/gnmifaucet/faucet_agent/context"
	"github.com/alshaboti/gnmifaucet/faucet_agent/gnmi"
	"github.com/alshaboti/gnmifaucet/faucet_agent/syscmd"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"

	log "github.com/golang/glog"
	pb "github.com/openconfig/gnmi/proto/gnmi"
)

var (
	gnmiPort       = flag.Int("gnmi_port", 8080, "The port GNMI server listening on.")

	cmdRunner = syscmd.Runner()
)

func main() {
	flag.Parse()
	log.Info("Faucet gnmi agent started!")

	deviceConfig := context.GetDeviceConfig()
	// Load hostname
	hostname, err := os.Hostname()
	if err != nil {
		log.Exit("Failed to load the device hostname.")
	}
	deviceConfig.Hostname = hostname
	log.Infof("Hostname = %s.", hostname)


	// Get gNMI server address.
	deviceIPv4, err := cmdRunner.DeviceIPv4()
	if err != nil {
		log.Exit("Failed to load the device IPv4 address.")
	}
	gNMIServerAddr := fmt.Sprintf("%s:%d", deviceIPv4, *gnmiPort)
	deviceConfig.GNMIServerAddr = gNMIServerAddr

	// Create GNMI server.
	gnmiServer, err := gnmi.NewServer()
	if err != nil {
		log.Exitf("Failed to create the GNMI server. Error: %v.", err)
	}

	// Start the GNMI server.
	var opts []grpc.ServerOption
	//if *controllerAddr == "" {
		// Add credential check if no controller specified.
	opts = credentials.ServerCredentials()
	//}
	g := grpc.NewServer(opts...)
	pb.RegisterGNMIServer(g, gnmiServer)
	reflection.Register(g)
	listen, err := net.Listen("tcp", gNMIServerAddr)
	if err != nil {
		log.Exitf("Failed to listen on %s. Error: %v.", gNMIServerAddr, err)
	}

	log.Infof("Running GNMI server. Listen on %s.", gNMIServerAddr)
	if err := g.Serve(listen); err != nil {
		log.Exitf("Failed to run GNMI server on %s. Error: %v.", gNMIServerAddr, err)
	}
}
