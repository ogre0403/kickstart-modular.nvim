FROM debian:12-slim

RUN apt update && \
    apt install -y make gcc ripgrep unzip git xclip curl


RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
    rm -rf /opt/nvim-linux64 && \
    mkdir -p /opt/nvim-linux64 && \
    chmod a+rX /opt/nvim-linux64 && \
    tar -C /opt -xzf nvim-linux64.tar.gz &&\
    ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/

RUN apt clean && \
    rm /nvim-linux64.tar.gz

# required for copilot.lua
RUN apt install -y nodejs 

WORKDIR /root

RUN mkdir -p /root/.config/nvim

COPY ./ /root/.config/nvim/

RUN nvim --headless PlugInstall +qall && \
    nvim --headless +"MasonInstall lua-language-server stylua" +qall
