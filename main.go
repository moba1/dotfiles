package main

import (
	"flag"
	"fmt"
	"log"

	"github.com/moba1/dotfiles/taskset/commonset"
	"github.com/moba1/dotfiles/taskset/darwinset"
	"github.com/moba1/dotsetup"
)

func main() {
	cs := commonset.Commands()
	switch dotsetup.Os {
	case "windows":
		log.Fatalln("windows not supported")
	case "darwin":
		cs = append(darwinset.Commands(), cs...)
	}
	s := dotsetup.NewScript(cs)

	flag.BoolVar(&s.Debug, "debug", false, "debug mode")
	dryRun := flag.Bool("dry-run", false, "dry run")
	flag.Parse()

	if *dryRun {
		for _, command := range s.Flat() {
			fmt.Println(command)
		}
		return
	}

	if err := s.Execute(); err != nil {
		log.Fatalln(err)
	}
}
