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

echo "deb https://deb.debian.org/debian experimental main" | sudo tee -a /etc/apt/sources.list
sudo apt -y update
sudo apt -y install neovim

echo "All packages from the setup script have been installed."

git clone https://github.com/feakuru/nvim-config.git "$XDG_CONFIG_HOME"/nvim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -sf "$PWD/.zshrc" "$HOME"/.zshrc

echo "All configs have been set up."
