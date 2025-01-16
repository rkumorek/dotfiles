set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.local/cache
set -x XDG_RUNTIME_HOME $HOME/.local/runtime

set -x EDITOR nvim

# Colors and such.
set -x BAT_THEME ansi

# Load profile if exists.
if test -f $XDG_CONFIG_HOME/fish/local.fish
    source $XDG_CONFIG_HOME/fish/local.fish
end
