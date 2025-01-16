#!/usr/bin/env fish

if not set -q XDG_CONFIG_HOME
    echo XDG_CONFIG_HOME environment variable not set.
    return 1
end

set home $XDG_CONFIG_HOME
set dir (realpath (dirname (status -f)))

echo $dir

function check_path --argument-names path 
    if test -e $path
        read -l -P "Path $path already exists, delete? [y/n]? " confirmation
        if test $confirmation = 'y'
            rm -r $path
        else
            return 1
        end
    end
end

function link_config_dir --argument-names name
    set -l path "$home/$name"
    check_path $path && ln -vs "$dir/config/$name" $home
end

printf '\n[!] Linking .config folders:\n'
for config_dir in $(basename -a ./config/*)
    link_config_dir $config_dir
end

# printf '\n[!] Linking files:\n'
# files=".tmux.conf .zprofile .zshrc"
# for file in $files
#     check_path "$HOME/$file" && ln -s "$dir/$file" "$HOME/$file"
# end

# printf '\n[!] Linking scripts:\n'
# for file in bin/*
#     check_path "/usr/local/$file" # && ln -s "$dir/$file" "/usr/local/$file"
# end

