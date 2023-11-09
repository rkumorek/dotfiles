#!/bin/bash

if [ -z "$XDG_CONFIG_HOME" ]; then
    echo "XDG_CONFIG_HOME environment variable not set."
    exit 1
fi

home="$XDG_CONFIG_HOME"
dir="$(realpath "$(dirname "$(readlink -f "$0")")")"

check_path() {
    if [ -e "$1" ]; then
        read -p "Path $1 already exists, delete? [y/n]? " confirmation
        if [ "$confirmation" = 'y' ]; then
            rm -r "$1"
        else
            return 1
        fi
    fi
}

link_config_dir() {
    local path="$home/$1"
    if check_path "$path"; then
        ln -vs "$dir/config/$1" "$home"
    fi
}

printf '\n[!] Linking .config folders:\n'
for config_dir in $(basename -a ./config/*); do
    link_config_dir "$config_dir"
done

printf '\n[!] Linking files:\n'
files=".tmux.conf .zprofile .zshrc"
for file in $files; do
    check_path "$HOME/$file" && ln -s "$dir/$file" "$HOME/$file"
done
