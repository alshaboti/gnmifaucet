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
        "errors"
//        "fmt"
  //      "time"

    //    "github.com/alshaboti/gnmifaucet/faucet_agent/context"
      //  "github.com/alshaboti/gnmifaucet/faucet_agent/service"
        "github.com/alshaboti/gnmifaucet/faucet_agent/syscmd"
//        "github.com/alshaboti/gnmifaucet/faucet_agent/util/ocutil"
        "github.com/alshaboti/gnmifaucet/generated/ocstruct"
        "github.com/openconfig/ygot/ygot"

        log "github.com/golang/glog"
)

var (
        cmdRunner = syscmd.Runner()
)

// handleSet is the callback function of the GNMI SET call.
// It is triggered by the GNMI server.
func handleSet(updatedConfig ygot.ValidatedGoStruct) error {
        // TODO: Handle delta change.
        faucetconf, ok := updatedConfig.(*ocstruct.Device)
        if !ok {
                return errors.New("new configuration has invalid type")
        }

        configString, err := ygot.EmitJSON(faucetconf, &ygot.EmitJSONConfig{
                Format: ygot.RFC7951,
                Indent: "  ",
                RFC7951Config: &ygot.RFC7951JSONConfig{
                        AppendModuleName: false,
                },
        })
        if err != nil {
                return err
        }
        log.Infof("Received a new configuration for fuacet:\n%v\n", configString)


        // Save the succeeded config file.
        if err := syscmd.SaveToFile(runFolder, faucetConfigFileName, configString); err != nil {
                return err
        }
        log.Info("Saved the configuration to file.")
        return nil
}
