package commonset

import (
	"path"

	"github.com/moba1/dotfiles/env"
	"github.com/moba1/dotsetup"
)

func bat() []dotsetup.Command {
	cs := []dotsetup.Command{
		// install bat
		&dotsetup.Package{
			Name: "bat",
		},
	}

	// put configuration file
	batCfgPath := path.Join(env.User.HomeDir, ".config", "bat")
	cs = append(cs, &dotsetup.Directory{
		Path: batCfgPath,
	})
	configFilename := "config"
	cs = append(cs, &dotsetup.Link{
		Source:      path.Join(env.AssetPath, "bat", configFilename),
		Destination: path.Join(batCfgPath, configFilename),
		Force:       true,
	})

	return cs
}
