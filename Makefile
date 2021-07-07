docker_image := dotfiles
docker_run := docker run -it --rm -v "$(shell pwd):/home/moba/.setup" $(docker_image):latest
.PHONY: all, debug, dry-run, build, run

all:
	go run main.go

run-image:
	$(docker_run) -l -c "go run main.go"

debug-image: build-image
	$(docker_run) -l -c "go run main.go -debug"

dry-run-image: build-image
	$(docker_run)

build-image:
	docker build -t $(docker_image):latest .
