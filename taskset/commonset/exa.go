package commonset

import "github.com/moba1/dotsetup/v2"

func exa() []dotsetup.Task {
	return []dotsetup.Task{
		// install exa
		&dotsetup.Package{
			Name: "exa",
		},
	}
}
