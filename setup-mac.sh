#!/usr/bin/env bash
set -euo pipefail

printf '\n[!] Installing Homebrew:\n'
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "brew already installed"
fi

# brew isn't on PATH right after a fresh install
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

printf '\n[!] Installing packages:\n'
packages=(
    tmux
    fish
    git-delta
    bat
    gh
    fnm
    # neovim build deps
    ninja
    cmake
    gettext
)
brew install "${packages[@]}"

printf '\n[!] Installing apps:\n'
casks=(
    ghostty
    google-chrome
    microsoft-teams
    microsoft-outlook
)
for cask in "${casks[@]}"; do
    if brew list --cask "$cask" >/dev/null 2>&1; then
        echo "$cask already installed"
    # fails if the app was installed outside brew, don't stop the whole setup for it
    elif ! brew install --cask "$cask"; then
        echo "[warn] $cask failed to install, is it already in /Applications?"
    fi
done

printf '\n[!] Setting keyboard layout to Polish Pro (programmer):\n'
# writing HIToolbox defaults only takes effect after a re-login, so switch through the
# Text Input Sources API instead: applies immediately and persists, other layouts get removed
swift - <<'EOF'
import Carbon
func id(_ s: TISInputSource) -> String { Unmanaged<CFString>.fromOpaque(TISGetInputSourceProperty(s, kTISPropertyInputSourceID)).takeUnretainedValue() as String }
let target = "com.apple.keylayout.PolishPro"
let src = (TISCreateInputSourceList([kTISPropertyInputSourceID: target] as CFDictionary, true).takeRetainedValue() as! [TISInputSource])[0]
TISEnableInputSource(src)
TISSelectInputSource(src)
let enabled = TISCreateInputSourceList([kTISPropertyInputSourceCategory: kTISCategoryKeyboardInputSource!] as CFDictionary, false).takeRetainedValue() as! [TISInputSource]
for s in enabled where id(s) != target && id(s).hasPrefix("com.apple.keylayout.") { TISDisableInputSource(s) }
EOF
echo "done"

printf '\n[!] Setting key repeat:\n'
# units of 15ms: 210ms initial delay, 45ms repeat interval
defaults write -g InitialKeyRepeat -int 14
defaults write -g KeyRepeat -int 3
# repeat held keys instead of showing the accent picker
defaults write -g ApplePressAndHoldEnabled -bool false
echo "done, log out and back in to apply"
