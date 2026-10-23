# dotfiles

- `setup-mac.sh`: installs Homebrew, packages and casks, and sets macOS defaults
- `install.fish`: links the configs

## Notes

### Dactyl (ZMK) keyboard types `§` instead of `` ` ``

ZMK doesn't report a physical layout, so macOS falls back to the built-in keyboard's layout (ISO).
When that happens, the top-left key types `§` instead of `` ` ``. To force ANSI:

```sh
sudo defaults write /Library/Preferences/com.apple.keyboardtype keyboardtype -dict-add "24926-7504-0" -int 40
```

The key is `<ProductID>-<VendorID>-0` in decimal (0x615e, 0x1d50), and the value `40` means ANSI.
It takes effect after the keyboard reconnects. To undo:

```sh
sudo /usr/libexec/PlistBuddy -c 'Delete :keyboardtype:24926-7504-0' /Library/Preferences/com.apple.keyboardtype.plist
```
