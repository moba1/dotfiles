package darwinset

import "github.com/moba1/dotsetup"

func Commands() []dotsetup.Command {
	tfs := []func() []dotsetup.Command{
		homebrew,
	}
	ts := []dotsetup.Command{}
	for _, tf := range tfs {
		ts = append(ts, tf()...)
	}

	return ts
}
