docker_image := dotfiles
docker_run := docker run -it --rm -v "$(shell pwd):/home/moba/.setup" $(docker_image):latest
.PHONY: all, debug, dry-run, build, run

all:
	go run main.go

dry-run: build-image
	$(docker_run) -l -c "go run main.go -debug -y"

start-image: build-image
	$(docker_run)

build-image:
	docker build -t $(docker_image):latest .
