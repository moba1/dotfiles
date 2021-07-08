package commonset

import (
	"fmt"
	"path"

	"github.com/moba1/dotfiles/env"
	"github.com/moba1/dotsetup/v2"
)

func vim() []dotsetup.Task {
	ts := []dotsetup.Task{}

	// install vim
	var vimPackName string
	switch dotsetup.Os {
	case "Arch Linux":
		vimPackName = "gvim"
	case "darwin":
		vimPackName = "macvim"
	default:
		vimPackName = "vim"
	}
	ts = append(ts, &dotsetup.Package{
		Name: vimPackName,
	})
	// install neovim
	ts = append(ts, &dotsetup.Package{
		Name: "neovim",
	})

	// setup rc file
	assetPath := path.Join(env.AssetPath, "vim")
	rcs := map[string]string{
		"vim":  "vimrc",
		"gvim": "gvimrc",
	}
	for _, rc := range rcs {
		ts = append(ts, &dotsetup.Link{
			Source:      path.Join(assetPath, rc),
			Destination: path.Join(env.User.HomeDir, fmt.Sprintf(".%s", rc)),
			Force:       true,
		})
	}
	nvimConfigPath := path.Join(env.User.HomeDir, ".config", "nvim")
	ts = append(ts, &dotsetup.Directory{
		Path: nvimConfigPath,
	})
	ts = append(ts, &dotsetup.Link{
		Source:      path.Join(assetPath, rcs["vim"]),
		Destination: path.Join(nvimConfigPath, "init.vim"),
		Force:       true,
	})

	// install vim-plug & plugins
	autoloadPaths := []string{
		path.Join(env.User.HomeDir, ".vim", "autoload"),
		path.Join(env.User.HomeDir, ".local", "share", "nvim", "site", "autoload"),
	}
	for _, autoloadPath := range autoloadPaths {
		ts = append(ts, &dotsetup.Curl{
			Args: []string{
				"-fLo", path.Join(autoloadPath, "plug.vim"),
				"--create-dirs",
				"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"},
		})
	}
	ts = append(ts, &dotsetup.Execute{
		RawCommands: []dotsetup.ExecuteCommand{
			{
				RawCommand: dotsetup.RawCommand{
					"vim", "-s",
					path.Join(env.User.HomeDir, ".vimrc"),
					"+PlugInstall", "+qall",
				},
				DoRool: false,
			},
		},
	})

	return ts
}
