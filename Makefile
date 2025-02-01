
IMG_NAME = "ogre0403/nvim:latest"
ZSH_PROFILE = ${HOME}/.zshrc
BASH_PROFILE = ${HOME}/.bashrc

all : build install
.PHONY : all

.PHONY: build
build:
	docker build -t $(IMG_NAME) -f dockerized/Dockerfile .

.PHONY: install
install:
	@if [ -f $(ZSH_PROFILE) ];  then zsh  ./dockerized/install.sh $(ZSH_PROFILE);  fi
	@if [ -f $(BASH_PROFILE) ]; then bash ./dockerized/install.sh $(BASH_PROFILE); fi

	
