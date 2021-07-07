package env

import (
	"log"
	"os"
	"path"
)

var ProjectRootPath string
var AssetPath string

func init() {
	wd, err := os.Getwd()
	if err != nil {
		log.Fatalln(err)
	}
	ProjectRootPath = wd

	AssetPath = path.Join(ProjectRootPath, "assets")
}
