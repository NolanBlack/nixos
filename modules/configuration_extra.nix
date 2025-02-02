{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        libreoffice # office docs
        spotify # music
        zathura # pdf (minimal)
        okular  # pdf
        ghostwriter # markdown
        gthumb # photo viewer/edior
        brave # chromium browser option
        #zoom-us # video conference
    ];
}
