# fnm: node version manager, switches versions on cd when .nvmrc/.node-version is present
if command -q fnm
    fnm env --use-on-cd --version-file-strategy=recursive --shell fish | source
end
