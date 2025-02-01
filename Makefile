
IMG_NAME = "ogre0403/nvim:latest"

build:
	docker build -t $(IMG_NAME) -f dockerized/Dockerfile .
