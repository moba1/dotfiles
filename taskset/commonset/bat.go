package commonset

import (
	"path"

	"github.com/moba1/dotfiles/env"
	"github.com/moba1/dotsetup/v2"
)

func bat() []dotsetup.Task {
	ts := []dotsetup.Task{
		// install bat
		&dotsetup.Package{
			Name: "bat",
		},
	}

	// put configuration file
	batCfgPath := path.Join(env.User.HomeDir, ".config", "bat")
	ts = append(ts, &dotsetup.Directory{
		Path: batCfgPath,
	})
	configFilename := "config"
	ts = append(ts, &dotsetup.Link{
		Source:      path.Join(env.AssetPath, "bat", configFilename),
		Destination: path.Join(batCfgPath, configFilename),
		Force:       true,
	})

	return ts
}
