package main

import (
	"flag"
	"fmt"
	"log"
	"os/exec"

	"github.com/moba1/dotfiles/taskset/commonset"
	"github.com/moba1/dotsetup"
)

func main() {
	cs := commonset.Commands()
	switch dotsetup.Os {
	case "windows":
		log.Fatalln("windows not supported")
	case "darwin":
		cmd := exec.Command("command", "-v", "brew")
		if err := cmd.Run(); err == nil {
			break
		}
		log.Fatalln("Homebrew not installed. Could you install Homebrew?")
	}
	s := dotsetup.NewScript(cs)

	flag.BoolVar(&s.Debug, "debug", false, "debug mode")
	dryRun := flag.Bool("dry-run", false, "dry run")
	flag.Parse()

	if *dryRun {
		for _, command := range s.Flat() {
			fmt.Println(fmt.Sprintf("%#v", command))
		}
		return
	}

	if err := s.Execute(); err != nil {
		log.Fatalln(err)
	}
}
