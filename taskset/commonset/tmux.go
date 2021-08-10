package commonset

import (
	"fmt"
	"path"

	"github.com/moba1/dotfiles/env"
	"github.com/moba1/dotsetup/v3"
)

func tmux() []dotsetup.Task {
	ts := []dotsetup.Task{
		// install tmux
		&dotsetup.Package{
			Name: "tmux",
		},
	}

	// setup configuration
	rc := "tmux.conf"
	ts = append(ts, &dotsetup.Link{
		Source:      path.Join(path.Join(env.AssetPath, "tmux", rc)),
		Destination: path.Join(env.User.HomeDir, fmt.Sprintf(".%s", rc)),
		Force:       true,
	})

	return ts
}
