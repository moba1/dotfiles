package commonset

import "github.com/moba1/dotsetup"

func fd() []dotsetup.Command {
	var packName string
	switch dotsetup.Os {
	case "darwin":
		packName = "fd"
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
