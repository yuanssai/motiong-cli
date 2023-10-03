/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package main

import "github.com/yuanssai/motiong-cli/cmd"
import _ "github.com/yuanssai/motiong-cli/cmd/bar"
import _ "github.com/yuanssai/motiong-cli/cmd/foo"

func main() {
	cmd.Execute()
}
