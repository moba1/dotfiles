package commonset

import "github.com/moba1/dotsetup"

func Commands() []dotsetup.Command {
	tfs := []func() []dotsetup.Command{
		fish,
		tmux,
		vim,
		bat,
		exa,
		fd,
	}
	ts := []dotsetup.Command{}
	for _, tf := range tfs {
		ts = append(ts, tf()...)
	}

	return ts
}
