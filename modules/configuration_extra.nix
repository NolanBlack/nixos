{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        libreoffice # office docs
        spotify # music
        zathura # pdf (minimal)
        kdePackages.okular  # pdf
        kdePackages.ghostwriter # markdown
        gthumb # photo viewer/edior
        brave # chromium browser option
        #zoom-us # video conference
    ];
}
