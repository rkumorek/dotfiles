export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# pip3
export PATH="/Users/rafalkumorek/Library/Python/3.9/bin:$PATH"

# bun completions
[ -s "/Users/rafalkumorek/.bun/_bun" ] && source "/Users/rafalkumorek/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/rafalkumorek/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end