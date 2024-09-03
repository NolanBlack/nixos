Rebuild system after updating /etc/configuration.nix
```
sudo nixos-rebuild switch
```

To reset GNOME xkb settings (and obey the options set in configuration.nix):
```
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
```

rebuild with flake
```
sudo nixos-rebuild switch --flake /etc/nixos/#default
```
genere home.nix
```
nix run home-manager/master -- init && \
  sudo cp ~/.config/home-manager/home.nix /etc/nixos/
```

# TODO
git manage nixos
home-manager dotfiles 
    vim
    bash/zsh
    hyprland
    waybar
    theming
    login screen
paraview
petsc
my projects
cisco
tmux

