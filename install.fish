#!/usr/bin/env fish

set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME $HOME/.config

# Symlinks to create, as "repo path -> target path" (target may use $HOME / $XDG_CONFIG_HOME)
set links \
    ".tmux.conf -> $HOME/.tmux.conf" \
    "config/git -> $XDG_CONFIG_HOME/git" \
    "config/ghostty -> $XDG_CONFIG_HOME/ghostty" \
    "config/fish/conf.d/brew.fish -> $XDG_CONFIG_HOME/fish/conf.d/brew.fish" \
    "config/fish/conf.d/fnm.fish -> $XDG_CONFIG_HOME/fish/conf.d/fnm.fish"

set dir (realpath (dirname (status -f)))

echo $dir

# Returns 0 if $path is free to link to $target (deleting it after confirmation if needed)
function check_path --argument-names path target
    # already linked, nothing to do
    if test "$(readlink $path 2>/dev/null)" = $target
        echo "$path already linked"
        return 1
    end

    # test -L catches dangling symlinks which test -e misses
    if test -e $path; or test -L $path
        read -l -P "Path $path already exists, delete? [y/n]? " confirmation
        if test "$confirmation" = y
            rm -r $path
        else
            return 1
        end
    end
end

function link --argument-names target path
    if not test -e $target
        echo "[skip] $target does not exist"
        return
    end
    mkdir -p (dirname $path)
    if check_path $path $target
        ln -vs $target $path
    end
end

printf '\n[!] Linking:\n'
for entry in $links
    set -l parts (string split -- ' -> ' $entry)
    link $dir/$parts[1] $parts[2]
end

printf '\n[!] Setting fish as default shell:\n'
# not `status fish-path`, which resolves to the versioned Cellar path and breaks on upgrade
set fish_path (command -s fish)
if not grep -qxF $fish_path /etc/shells
    echo $fish_path | sudo tee -a /etc/shells >/dev/null
end
if test "$(dscl . -read /Users/$USER UserShell | string split -f2 ' ')" != $fish_path
    chsh -s $fish_path
else
    echo "fish already default shell"
end

printf '\n[!] Installing node LTS:\n'
if not command -q fnm
    echo "[skip] fnm not installed, run setup-mac.sh first"
else if fnm list | string match -qr "v\d+"
    echo "node already installed via fnm"
else
    # fnm makes the first installed version the default
    fnm install --lts
end
