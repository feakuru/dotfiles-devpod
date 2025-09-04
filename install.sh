#!/bin/bash
CURRENT_DIR=$(pwd)
echo "Starting dotfile setup from path: $CURRENT_DIR"
export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

sudo apt -y update
sudo apt -y upgrade
sudo apt -y autoremove
sudo apt -y install yes

packages=(
    curl
    cmake
    fd
    fzf
    git
    make
    unzip
    gcc
    ripgrep
    zsh
    zoxide
)
for package in "${packages[@]}"; do
    echo "Installing $package..."
    yes | sudo apt -y install "$package"
done

echo "Installing nvm and Node v20..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
bash -c "nvm install 20"
bash -c "nvm use 20"

echo "All packages from the setup script have been installed."

echo "Building Neovim from source."
cd ~
git clone https://github.com/neovim/neovim
cd neovim
git checkout tags/v0.11.1
echo $PATH
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux-x86_64.deb
cd $CURRENT_DIR

sudo rm -rf "$XDG_CONFIG_HOME"/nvim
git clone https://github.com/feakuru/nvim-config.git "$XDG_CONFIG_HOME"/nvim
sudo rm -rf /home/vscode/.oh-my-zsh
sudo su -s /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" - vscode

ln -sf "$PWD/.zshrc" "$HOME"/.zshrc
sudo chsh vscode --shell /bin/zsh

echo "All configs have been set up."
