#!/usr/bin bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

config_dots=(
    "nvim"
    "starship"
    "sway"
    "swaylock"
    "tmux"
    "waybar"
    "wlogout"
    "wofi"
    "foot"
)

home_dots=(
    ".zshrc"
    ".zsh_profile"
)

for dot in "${home_dots[@]}"; do
    if [ -f "${HOME}/${dot}" ]; then
        echo "${HOME}/${dot} already exists, skipping"
        continue
    fi

    ln -s "${SCRIPT_DIR}/${dot}" "${HOME}/${dot}"
done

for dot in "${config_dots[@]}"; do
    if [ -d "${HOME}/.config/${dot}" ]; then
        if [ ! -z "$(ls -A ${HOME}/.config/${dot})" ]; then
            echo "${HOME}/.config/${dot} already exists and is not empty, skipping"
            continue
        fi
    else
        mkdir "${HOME}/.config/${dot}"
    fi

    stow ${dot} -t "${HOME}/.config/${dot}"
done
