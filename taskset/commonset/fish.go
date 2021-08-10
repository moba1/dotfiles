package commonset

import (
	"path"

	"github.com/moba1/dotfiles/env"
	"github.com/moba1/dotsetup/v3"
)

func fish() []dotsetup.Task {
	ts := []dotsetup.Task{
		// install fish
		&dotsetup.Package{
			Name: "fish",
		},
	}

	// create configuration directory for fish
	fishCfgPath := path.Join(env.User.HomeDir, ".config", "fish")
	ts = append(ts, &dotsetup.Directory{
		Path: path.Join(fishCfgPath),
	})

	for _, p := range []string{"config.fish", "functions"} {
		ts = append(ts, &dotsetup.Link{
			Source:      path.Join(env.AssetPath, "fish", p),
			Destination: path.Join(fishCfgPath),
			Force: true,
		})
	}

	// create .config/fish/completions directory
	completionPath := path.Join(fishCfgPath, "completions")
	ts = append(ts, &dotsetup.Directory{
		Path: completionPath,
	})
	// install docker completion
	ts = append(ts, &dotsetup.Curl{
		Args: []string{
			"-o", path.Join(completionPath, "docker.fish"),
			"https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish",
		},
	})

	return ts
}
