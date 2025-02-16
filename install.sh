#!/bin/bash

# copy lazygit
cp bin/* /usr/bin/

# install rebuild package
sudo dpkg -i nvim-linux-arm64.deb

# delete current config
rm ~/.config/nvim/
cp nvim ~/.config/
