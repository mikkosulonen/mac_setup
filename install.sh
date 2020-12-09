#!/bin/sh

echo "Creating an SSH key for you..."
ssh-keygen -t rsa

echo "Git config"
git config --global user.name "Mikko Sulonen"
git config --global user.email mikko.sulonen@solita.fi

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

mkdir ~/source
cd ~/source
git clone git@github.com:mikkosulonen/mac_setup.git
cp ~/source/mac_setup/Brewfile ~/Brewfile

echo "Install XCode CLI Tool"
xcode-select --install


echo "Installing Homebrew"
if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Installing Homebrew apps via Brewbundle"
brew bundle

echo "Set screenshots to Documents/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Documents/Screenshots"

echo "Installing vs-code extensions"
if test ! $(code --version); then
    cat ~/source/mac_setup/vs_code_extensions.txt | xargs -L 1 code --install-extension
fi

echo "Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
