FROM debian:12-slim

RUN apt update && \
    apt install -y make gcc ripgrep unzip git xclip curl fzf


ENV NVIM_VERSION=v0.10.4
ENV NVM_VERSION=v0.40.0
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=20


RUN curl -LO https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz && \
    rm -rf /opt/nvim-linux-x86_64 && \
    mkdir -p /opt/nvim-linux-x86_64 && \
    chmod a+rX /opt/nvim-linux-x86_64 && \
    tar -C /opt -xzf nvim-linux-x86_64.tar.gz &&\
    ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/

RUN apt clean && \
    rm /nvim-linux-x86_64.tar.gz

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \ 
    echo 'source $NVM_DIR/nvm.sh' >> /etc/profile


RUN /bin/bash -l -c "nvm install ${NODE_VERSION}" && \
    /bin/bash -l -c "nvm use ${NODE_VERSION}" && \
    /bin/bash -l -c "npm install -g tree-sitter-cli"


RUN mkdir -p /root/.config/nvim

COPY ./ /root/.config/nvim/

RUN bash -l -c "nvim --headless PlugInstall +qall" && \
    bash -l -c "nvim --headless +\"MasonInstall lua-language-server stylua\" +qall"

CMD ["bash","-c", "-l", "nvim"]
