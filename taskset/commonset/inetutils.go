package commonset

import (
	"github.com/moba1/dotsetup/v3"
)

func inetutils() []dotsetup.Task {
	ts := []dotsetup.Task{}

	switch dotsetup.Os {
	case "arch":
		ts = append(ts, &dotsetup.Package{
			Name: "inetutils",
		})
	}

	return ts
}
