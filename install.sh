#!bin/bash

# copy lazygit and nvim
cp bin/* /usr/bin/

# delete current config
rm ~/.config/nvim/
cp nvim ~/.config/
