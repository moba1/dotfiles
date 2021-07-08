package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"os"
	"os/exec"

	"github.com/moba1/dotfiles/taskset/commonset"
	"github.com/moba1/dotsetup/v2"
)

func main() {
	ts := commonset.Tasks()
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
	s := dotsetup.NewScript(ts)

	flag.BoolVar(&s.Debug, "debug", false, "debug mode")
	dryRun := flag.Bool("dry-run", false, "dry run")
	yes := flag.Bool("y", false, "non interactive mode")
	flag.Parse()

	if *dryRun {
		for _, command := range s.Flat() {
			fmt.Println(fmt.Sprintf("%#v", command))
		}
		return
	}

	var sudoPass string
	if !*yes && dotsetup.Os != "darwin" {
		fmt.Print("input user password (for sudo) --> ")
		if err := bufio.NewWriter(os.Stdout).Flush(); err != nil {
			log.Fatalln(err)
		}
		passwordReader := bufio.NewReader(os.Stdin)
		p, err := passwordReader.ReadString('\n')
		if err != nil {
			log.Fatalln(err)
		}
		sudoPass = p
	}

	if err := s.Execute(sudoPass); err != nil {
		log.Fatalln(err)
	}
}
