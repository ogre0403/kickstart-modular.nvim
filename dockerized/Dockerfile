FROM ubuntu:24.04


RUN apt update && \
    apt install -y make gcc ripgrep unzip git curl wget


RUN apt install -y tmux && \
    echo 'set -g status off'                >> /root/.tmux.conf && \
    echo 'set-option -sg escape-time 10'    >> /root/.tmux.conf && \
    echo 'set-option -g focus-events on'    >> /root/.tmux.conf


RUN apt install -y locales && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen  && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8


ENV NVIM_VERSION=v0.10.4
ENV NVM_VERSION=v0.40.0
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=20
ENV FZF_VERSION=0.59.0


# Install Specific version 
ARG BUILDPLATFORM
RUN if [ "$BUILDPLATFORM" = "linux/arm64" ]; then \
        echo "Download ARM66 version"; \
        curl -o nvim-linux.tar.gz -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-arm64.tar.gz ; \
        curl -o fzf.tar.gz        -L https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_arm64.tar.gz ; \
    else \
        echo "Download AMD64 version"; \
        curl -o nvim-linux.tar.gz -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz ;\
        curl -o fzf.tar.gz        -L https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz ; \
    fi


RUN echo "Install nvim ${NVIM_VERSION} from binary" && \
    rm -rf /opt/nvim-linux                          && \
    mkdir -p /opt/nvim-linux                        && \
    chmod a+rX /opt/nvim-linux                      && \
    tar -C /opt/nvim-linux --strip-components=1 -xzf nvim-linux.tar.gz &&\
    ln -sf /opt/nvim-linux/bin/nvim /usr/local/bin/ && \
    echo ""                                         &&\
    echo "Install fzf ${FZF_VERSION} from binary"   && \
    rm -rf /opt/fzf                                 && \
    mkdir -p /opt/fzf                               && \
    chmod a+rX /opt/fzf                             && \
    tar -C /opt/fzf -xzf fzf.tar.gz                 &&\
    ln -sf /opt/fzf/fzf /usr/local/bin/


RUN apt clean && \
    rm /nvim-linux.tar.gz  && \
    rm /fzf.tar.gz


RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \ 
    echo 'source $NVM_DIR/nvm.sh' >> /etc/profile


ENV NPM_PKG_VER_NEOVIM=5.3.0
ENV NPM_PKG_VER_TREE_SITTER=0.24.7

RUN /bin/bash -l -c "nvm install ${NODE_VERSION}" && \
    /bin/bash -l -c "nvm use ${NODE_VERSION}" && \
    /bin/bash -l -c "npm install -g tree-sitter-cli@${NPM_PKG_VER_TREE_SITTER}" && \
    /bin/bash -l -c "npm install -g neovim@${NPM_PKG_VER_NEOVIM}"


RUN mkdir -p /root/.config/nvim


COPY ./lua      /root/.config/nvim/lua
COPY ./init.lua /root/.config/nvim/

RUN bash -l -c "nvim --headless PlugInstall +qall"                                        && \
    bash -l -c "nvim --headless +\"MasonInstall lua-language-server  stylua     \" +qall" && \
    bash -l -c "nvim --headless +\"MasonInstall bash-language-server shfmt      \" +qall" && \
    bash -l -c "nvim --headless +\"MasonInstall yaml-language-server            \" +qall"


COPY dockerized/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
