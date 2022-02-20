package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

func main() {
	if err := run(); err != nil {
		panic(err)
	}
}

func run() error {
	var cmds [][]string
	for _, jsonArray := range os.Args[1:] {
		cmd, err := parseAsCmd(jsonArray)
		if err != nil {
			return err
		}
		cmds = append(cmds, cmd)
	}

	for _, cmd := range cmds {
		go func(cmd []string) {
			for {
				command := exec.Command(cmd[0], cmd[1:]...)
				command.Stdout = os.Stdout
				command.Stderr = os.Stderr
				command.Run()
				time.Sleep(1 * time.Second) // TODO: hard code
			}
		}(cmd)
	}

	// Wait forever
	<-make(chan struct{})
	return nil
}

func parseAsCmd(jsonArray string) ([]string, error) {
	var cmd []string
	err := json.NewDecoder(strings.NewReader(jsonArray)).Decode(&cmd)
	if err != nil {
		return nil, err
	}
	if len(cmd) == 0 {
		return nil, fmt.Errorf("array should have at least one element")
	}
	return cmd, nil
}
