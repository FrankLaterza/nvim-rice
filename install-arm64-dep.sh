#!/bin/bash

# copy lazygit
sudo cp bin/* /usr/bin/

# install rebuild package
sudo dpkg -i nvim-linux-arm64.deb

# delete current config
rm -r ~/.config/nvim/
cp -r ./nvim/ ~/.config/
