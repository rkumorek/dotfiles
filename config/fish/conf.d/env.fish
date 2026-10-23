# default editor for git, gh, crontab -e, fish Alt+E and anything else reading $EDITOR
set -gx EDITOR nvim

# bat: use the terminal's 16 ANSI colors so it follows the Ghostty theme
set -gx BAT_THEME ansi

# pnpm: global packages (pnpm add -g) live here
set -gx PNPM_HOME ~/Library/pnpm
fish_add_path -g $PNPM_HOME

# hydro prompt: named ANSI colours so it follows the Ghostty theme
set -g hydro_color_pwd blue
set -g hydro_color_git brblack
set -g hydro_color_prompt green
set -g hydro_color_duration yellow
set -g hydro_color_error red
