package commonset

import "github.com/moba1/dotsetup/v3"

func Tasks() []dotsetup.Task {
	tfs := []func() []dotsetup.Task{
		fish,
		vim,
		inetutils,
	}
	ts := []dotsetup.Task{}
	for _, tf := range tfs {
		ts = append(ts, tf()...)
	}

	return ts
}
