package darwinset

import "github.com/moba1/dotsetup"

func homebrew() []dotsetup.Command {
	return []dotsetup.Command{
		&dotsetup.Execute{
			RawCommand: []string{
				"/bin/bash",
				"-c",
				"echo | /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"",
			},
		},
	}
}
