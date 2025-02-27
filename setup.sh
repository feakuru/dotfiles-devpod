#!bin/bash
export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"


packages=(
    curl
    fd
    fzf
    git
    make
    unzip
    gcc
    ripgrep
    npm
    lazygit
    zsh
    yazi
    zoxide
)

for package in "${packages[@]}"; do
	echo "Installing $package..."
	apt-get install "$package"
done

echo "All packages from the setup script have been installed."

git clone https://github.com/feakuru/nvim-config.git "$XDG_CONFIG_HOME"/nvim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ln -sf "$PWD/.zshrc" "$HOME"/.zshrc

echo "All configs have been set up."
