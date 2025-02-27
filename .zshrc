export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

alias c=clear
alias v="[ -f \"./uv.lock\" ] && uv run nvim || nvim"
alias y=yazi

autoload -U bashcompinit
bashcompinit

# for ctrl+bcksp
bindkey '^H' backward-kill-word

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

eval "$(zoxide init zsh)"

export EDITOR=nvim
