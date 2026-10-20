#!/usr/bin/env fish
# Builds the custom Iosevka from private-build-plans.toml and installs it to ~/Library/Fonts

set iosevka_version v34.9.0
set plan iosevka-wider

set dir (realpath (dirname (status -f)))
set src (mktemp -d)

if not command -q fnm
    echo "fnm not installed, run setup-mac.sh first"
    exit 1
end
fnm env --shell fish | source
fnm use --install-if-missing lts-latest; or exit 1

git clone --depth 1 --branch $iosevka_version https://github.com/be5invis/Iosevka.git $src; or exit 1
cp $dir/private-build-plans.toml $src/
cd $src
npm ci; or exit 1
# macOS ignores TrueType hinting, so skip it and the ttfautohint dependency
npm run build -- ttf-unhinted::$plan; or exit 1

mkdir -p ~/Library/Fonts
cp -v dist/$plan/TTF-Unhinted/*.ttf ~/Library/Fonts/
rm -rf $src
