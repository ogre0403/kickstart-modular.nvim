
IMG_NAME = "ogre0403/nvim:latest"
ZSH_PROFILE = ${HOME}/.zshrc
BASH_PROFILE = ${HOME}/.bahrc

all : build install
.PHONY : all

.PHONY: build
build:
	docker build -t $(IMG_NAME) -f dockerized/Dockerfile .

.PHONY: install
install:
	@if [ -f $(ZSH_PROFILE) ];  then ./dockerized/install.sh $(ZSH_PROFILE);  fi
	@if [ -f $(BASH_PROFILE) ]; then ./dockerized/install.sh $(BASH_PROFILE); fi

	
