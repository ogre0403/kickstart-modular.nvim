FROM --platform=$BUILDPLATFORM debian:12-slim


# Setup Testing repository for fzf
RUN echo ""                                     >> /etc/apt/sources.list.d/debian.sources && \
    echo "Types: deb"                           >> /etc/apt/sources.list.d/debian.sources && \
    echo "URIs: http://deb.debian.org/debian/"  >> /etc/apt/sources.list.d/debian.sources && \
    echo "Suites: testing"                      >> /etc/apt/sources.list.d/debian.sources && \
    echo "Components: main"                     >> /etc/apt/sources.list.d/debian.sources && \
    echo "Package: *"                           >> /etc/apt/preferences.d/99pinning       && \
    echo "Pin: release a=stable"                >> /etc/apt/preferences.d/99pinning       && \
    echo "Pin-Priority: 900"                    >> /etc/apt/preferences.d/99pinning       && \
    echo ""                                     >> /etc/apt/preferences.d/99pinning       && \
    echo "Package: *"                           >> /etc/apt/preferences.d/99pinning       && \
    echo "Pin: release a=testing"               >> /etc/apt/preferences.d/99pinning       && \
    echo "Pin-Priority: 400"                    >> /etc/apt/preferences.d/99pinning


RUN apt update && \
    apt install -y make gcc ripgrep unzip git xclip curl wget && \ 
    apt install -t testing fzf 

ENV NVIM_VERSION=v0.10.4
ENV NVM_VERSION=v0.40.0
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=20

RUN if [ "$BUILDPLATFORM" = "linux/arm64" ]; then \
        echo "Download ARM64 version"; \
        curl -o nvim-linux.tar.gz -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-arm64.tar.gz ; \
    else \
        echo "Download AMD64 version"; \
        curl -o nvim-linux.tar.gz -L https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz ;\
    fi

RUN rm -rf /opt/nvim-linux && \
    mkdir -p /opt/nvim-linux && \
    chmod a+rX /opt/nvim-linux && \
    tar -C /opt/nvim-linux --strip-components=1 -xzf nvim-linux.tar.gz &&\
    ln -sf /opt/nvim-linux/bin/nvim /usr/local/bin/



RUN apt clean && \
    rm /nvim-linux.tar.gz

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

RUN bash -l -c "nvim --headless PlugInstall +qall" && \
    bash -l -c "nvim --headless +\"MasonInstall lua-language-server stylua shfmt\" +qall"


RUN apt install -y locales && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen  && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8


COPY dockerized/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
