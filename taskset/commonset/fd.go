package commonset

import "github.com/moba1/dotsetup/v3"

func fd() []dotsetup.Task {
	var packName string
	switch dotsetup.Os {
	case "darwin":
		packName = "fd"
	default:
		packName = "fd-find"
	}

	return []dotsetup.Task{
		// install fd
		&dotsetup.Package{
			Name: packName,
		},
	}
}
