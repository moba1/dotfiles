package commonset

import (
	"fmt"
	"path"

	"github.com/moba1/dotfiles/env"
	"github.com/moba1/dotsetup"
)

func vim() []dotsetup.Command {
	cs := []dotsetup.Command{}

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
	cs = append(cs, &dotsetup.Package{
		Name: vimPackName,
	})
	// install neovim
	cs = append(cs, &dotsetup.Package{
		Name: "neovim",
	})

	// setup rc file
	assetPath := path.Join(env.AssetPath, "vim")
	rcs := map[string]string{
		"vim":  "vimrc",
		"gvim": "gvimrc",
	}
	for _, rc := range rcs {
		cs = append(cs, &dotsetup.Link{
			Source:      path.Join(assetPath, rc),
			Destination: path.Join(env.User.HomeDir, fmt.Sprintf(".%s", rc)),
			Force:       true,
		})
	}
	nvimConfigPath := path.Join(env.User.HomeDir, ".config", "nvim")
	cs = append(cs, &dotsetup.Directory{
		Path: nvimConfigPath,
	})
	cs = append(cs, &dotsetup.Link{
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
		cs = append(cs, &dotsetup.Curl{
			Args: []string{
				"-fLo", path.Join(autoloadPath, "plug.vim"),
				"--create-dirs",
				"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"},
		})
	}
	cs = append(cs, &dotsetup.Execute{
		RawCommand: []string{"vim", "+PlugInstall", "+qall"},
	})

	return cs
}
