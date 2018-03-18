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

package gnmi

import (
	"bufio"
	"errors"
	"fmt"
	"strings"

	"github.com/alshaboti/gnmifaucet/faucet_agent/syscmd"
	"github.com/alshaboti/gnmifaucet/generated/ocstruct"
	"github.com/openconfig/ygot/ygot"
	yaml "gopkg.in/yaml.v2"

	log "github.com/golang/glog"
)

var (
	cmdRunner = syscmd.Runner()
)

// handleSet is the callback function of the GNMI SET call.
// It is triggered by the GNMI server.
func handleSet(updatedConfig ygot.ValidatedGoStruct) error {
	// TODO: Handle delta change.
	faucetconfObj, ok := updatedConfig.(*ocstruct.Device)
	if !ok {
		return errors.New("new configuration has invalid type")
	}

	// serialized the object to json string

	faucetConfigJSON, err := ygot.EmitJSON(faucetconfObj, &ygot.EmitJSONConfig{
		Format: ygot.RFC7951,
		Indent: "  ",
		RFC7951Config: &ygot.RFC7951JSONConfig{
			AppendModuleName: false,
		},
	})

	if err != nil {
		return err
	}
	log.Infof("Received a new configuration for fuacet:\n%v\n", faucetConfigJSON)

	// check facuet config
	//	yamlVersion := *faucetconfObj.Version
	//	fmt.Println("Version is ", yamlVersion)
	//vlans
	//	keys := []uint16{}
	//	for key := range faucetconfObj.Vlans {
	//		keys = append(keys, key)
	//		fmt.Println(*faucetconfObj.Vlans[key].Vid)
	//	}

	//*Yaml marshal doesn't ignore null value,
	//I tried with omiteempty but need modification in ocstruct
	yamlbyte, err := yaml.Marshal(faucetconfObj)

	fmt.Print(removeNull(string(yamlbyte)))
	if err != nil {
		fmt.Print(string(yamlbyte))
	}

	// Save the succeeded config file.
	if err := syscmd.SaveToFile(runFolder, faucetConfigFileName, faucetConfigJSON); err != nil {
		return err
	}
	log.Info("Saved the configuration to file.")
	return nil
}

func removeNull(yamlString string) string {
	var str string
	scanner := bufio.NewScanner(strings.NewReader(yamlString))
	for scanner.Scan() {
		if !strings.Contains(scanner.Text(), "null") {
			str += scanner.Text() + "\n"
		}

	}
	return str

}
