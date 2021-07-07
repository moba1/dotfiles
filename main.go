package main

import (
	"flag"
	"log"

	"github.com/moba1/dotfiles/taskset/commonset"
	"github.com/moba1/dotsetup"
)

func main() {
	cs := commonset.Commands()
	s := dotsetup.NewScript(cs)

	flag.BoolVar(&s.Debug, "debug", false, "debug mode")
	flag.Parse()

	if err := s.Execute(); err != nil {
		log.Fatalln(err)
	}
}
