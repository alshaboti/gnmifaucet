#!/bin/bash
env GOOS=linux GOARCH=arm CC=arm-linux-gnueabi-gcc go build -o $GOPATH/bin/link022_agent agent/agent.go
