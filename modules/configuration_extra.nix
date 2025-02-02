{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        libreoffice # office docs
        spotify # music
        zathura # pdf (minimal)
        okular  # pdf
        ghostwriter # markdown
        gthumb # photo viewer/edior
        tmux # terminal multiplex
        brave # chromium browser option
        zoom-us # video conference

        # programming
        libgcc
        gnumake
        cmake
        python3
        filezilla
        eigen
        libtorch-bin
        texliveFull
        paraview
    ];
}
