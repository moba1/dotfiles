package commonset

import (
	"fmt"
	"path"

	"github.com/moba1/dotfiles/env"
	"github.com/moba1/dotsetup"
)

func tmux() []dotsetup.Command {
	cs := []dotsetup.Command{
		// install tmux
		&dotsetup.Package{
			Name: "tmux",
		},
	}

	// setup configuration
	rc := "tmux.conf"
	cs = append(cs, &dotsetup.Link{
		Source:      path.Join(path.Join(env.AssetPath, "tmux", rc)),
		Destination: path.Join(env.User.HomeDir, fmt.Sprintf(".%s", rc)),
		Force:       true,
	})

	return cs
}
