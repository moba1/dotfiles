package env

import (
	"log"
	"os/user"
)

var User *user.User

func init() {
	u, err := user.Current()
	if err != nil {
		log.Fatalln(err)
	}
	User = u
}
