package commonset

import "github.com/moba1/dotsetup"

func exa() []dotsetup.Command {
	return []dotsetup.Command{
		// install exa
		&dotsetup.Package{
			Name: "exa",
		},
	}
}
