
IMG_NAME = "ogre0403/nvim:latest"
SHELL_PROFILE = ${HOME}/.zshrc

all : build install
.PHONY : all

.PHONY: build
build:
	docker build -t $(IMG_NAME) -f dockerized/Dockerfile .

.PHONY: install
install:
	./dockerized/install.sh $(SHELL_PROFILE)
	
