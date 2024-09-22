# Usage

 ### will rebuild the system ###
```sh
./rebuild [flakename=default]
```
- create a new OS image for the bootloader
- save/commit all files (does not push)
- use this when you want to rebuild, save, and switch to a new record of the system

### test system rebuild without creating entry ###
```sh
./test [flakename=defualt]
```
- switch to the specified OS image for the life of this session
- use this when you want to rebuild, save files, but NOT create a new record of the system
- if you reload into an older OS version after testing, these configuration files
do NOT automatically revert to the configuration corresponding to that OS version
    - to revert these files, checkout the commit corresponding to the specified OS build

### to run home-manager update (update the doftiles). ###
```sh
./configure [flakename=defualt]
```

### update the flake record ###
```sh
nix flake update
```

### delete unused store objects ###
```sh
nix-collect-garbage
```

```sh
nix-collect-garbage --delete-older-than 7d
```
- deletes unused store objects AND 
permanently removes OS generations older than 7d

## fresh install
On a fresh install of nixos,
- don't forget to copy the hardware configuration in `/etc/nixos/hardware-configuration.nix`
to the appropriate location in this directory.
- add  `nix.settings.experimental-features = [ "nix-command" "flakes" ];` to `/etc/nixos/configuration.nix`,
then run `sudo nixos-rebuild switch` from the `/etc/nixos/` directory
- run `nix run home-manager init` to init home manager

Then you may navigate back to this directory and use the provided scripts.
