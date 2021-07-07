package commonset

import "github.com/moba1/dotsetup"

func fd() []dotsetup.Command {
	var packName string
	switch dotsetup.Os {
	default:
		packName = "fd-find"
	}

	return []dotsetup.Command{
		// install fd
		&dotsetup.Package{
			Name: packName,
		},
	}
}
