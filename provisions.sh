#!/usr/bin/env bash

echo "********************************"
echo "      Provision script for      "
echo "    Ubuntu Trusty Tahr 64bit    "
echo "         by Palli Moon          "
echo "********************************"

add-apt-repository ppa:djcj/screenfetch
apt-get update
apt-get install -y git g++ zsh sl tree screenfetch

# Install zsh with oh my zsh
if [ ! -d ~vagrant/.oh-my-zsh ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~vagrant/.oh-my-zsh
fi
cp ~vagrant/.oh-my-zsh/templates/zshrc.zsh-template ~vagrant/.zshrc
chown vagrant: ~vagrant/.zshrc
chsh -s /bin/zsh vagrant

# Clone dotfiles repository into user directory
git clone https://github.com/Palli-Moon/dotfiles.git ~vagrant/dotfiles


# Run screenfetch on startup/ssh
echo "echo \"\n\n\n\"" >> ~vagrant/.zshrc
echo "if [ -f /usr/bin/screenfetch ]; then screenfetch; fi" >> ~vagrant/.zshrc
