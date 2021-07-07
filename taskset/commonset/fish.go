package commonset

import (
	"path"

	"github.com/moba1/dotfiles/env"
	"github.com/moba1/dotsetup"
)

func fish() []dotsetup.Command {
	cs := []dotsetup.Command{
		// install fish
		&dotsetup.Package{
			Name: "fish",
		},
	}

	// create configuration directory for fish
	fishCfgPath := path.Join(env.User.HomeDir, ".config", "fish")
	cs = append(cs, &dotsetup.Directory{
		Path: path.Join(fishCfgPath),
	})

	for _, p := range []string{"config.fish", "functions"} {
		cs = append(cs, &dotsetup.Link{
			Source:      path.Join(env.AssetPath, "fish", p),
			Destination: path.Join(fishCfgPath),
			Force: true,
		})
	}

	// create .config/fish/completions directory
	completionPath := path.Join(fishCfgPath, "completions")
	cs = append(cs, &dotsetup.Directory{
		Path: completionPath,
	})
	// install docker completion
	cs = append(cs, &dotsetup.Curl{
		Args: []string{
			"-o", path.Join(completionPath, "docker.fish"),
			"https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish",
		},
	})

	return cs
}
