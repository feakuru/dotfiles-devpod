#!/bin/bash
export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"

sudo apt -y update
sudo apt -y upgrade

packages=(
    curl
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
	sudo apt -y install "$package"
done

echo "deb https://deb.debian.org/debian unstable main" | sudo tee -a /etc/apt/sources.list
echo "deb https://deb.debian.org/debian experimental main" | sudo tee -a /etc/apt/sources.list
sudo apt -y update
sudo apt -t experimental -y install neovim
sudo apt install fzf

echo "All packages from the setup script have been installed."

git clone https://github.com/feakuru/nvim-config.git "$XDG_CONFIG_HOME"/nvim
sudo rm -rf /home/vscode/.oh-my-zsh
sudo su -s /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" - vscode

ln -sf "$PWD/.zshrc" "$HOME"/.zshrc
sudo chsh vscode --shell /bin/zsh

echo "All configs have been set up."
