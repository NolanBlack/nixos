{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        libreoffice # office docs
        spotify # music
        zathura # pdf (minimal)
        # calibre # reader, pdf, epub
        kdePackages.okular  # pdf
        kdePackages.ghostwriter # markdown
        gthumb # photo viewer/edior
        brave # chromium browser option
        #zoom-us # video conference
        proton-vpn
        pyright # Installs pyright natively
        nodejs               # Required dependency for pyright
    ];
}
