#!/usr/bin/env bash

echo "********************************"
echo "      Provision script for      "
echo "    Ubuntu Trusty Tahr 64bit    "
echo "         by Palli Moon          "
echo "********************************"

apt-get update -q
apt-get install -yq git g++ zsh sl

# Install zsh with oh my zsh
if [ ! -d ~vagrant/.oh-my-zsh ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~vagrant/.oh-my-zsh
fi
cp ~vagrant/.oh-my-zsh/templates/zshrc.zsh-template ~vagrant/.zshrc
chown vagrant: ~vagrant/.zshrc
chsh -s /bin/zsh vagrant

# Clone dotfiles repository into user directory
git clone https://github.com/Palli-Moon/dotfiles.git ~vagrant/dotfiles