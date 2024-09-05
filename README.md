# usage
- `rebuild [flakename=default]` to rebuild system
    - create a new OS image for the bootloader
    - save/commit all files (does not push)
    - use this when you want to rebuild, save, and switch to a new record of the system

- `test [flakename=defualt]` to test system rebuild without creating entry
    - switch to the specified OS image for the life of this session
    - use this when you want to rebuild, save files, but NOT create a new record of the system
    - if you reload into an older OS version after testing, these configuration files
    do NOT automatically revert to the configuration corresponding to that OS version
        - to revert these files, checkout the commit corresponding to the specified OS build

- `config [flakename=defualt]` to run home-manager update

- `nix flake update` to update flakes

- `nix-collect-garbage` deletes unused store objects

- `nix-collect-garbage --delet-older-than 7d` deletes unused store objects AND 
permanently removes OS generations older than 7d

# TODO
hyprland
    move silent

petsc
hpfea
latex + zathura
