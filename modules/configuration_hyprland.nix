{ config, pkgs, inputs, ... }:

{
    # # hyprland
    # services.xserver.videosDrivers = ["nvidia"];
    # desktop portal
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gtk
    ];
    xdg.portal.xdgOpenUsePortal = true;

    services.xserver.displayManager.gdm.wayland = true;
    programs.hyprland = {
        enable = true;
        # set the flake package
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # make sure to also set the portal package, so that they are in sync
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables = {
        # If your cursor becomes invisible
        WLR_NO_HARDWARE_CURSORS = "1";
        # Hint electron apps to use wayland
        NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
        waybar
        (pkgs.waybar.overrideAttrs (oldAttrs: {
                        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                    })
        )
        pcmanfm # file manager
        dunst # notfications
        libnotify # for dunst
        swww # wallpapers
        kitty # term
        rofi # app launcher
        rofi-power-menu # power menu
        gscreenshot # screen shots
    ];

}

