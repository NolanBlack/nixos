# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
    ############################################################################
    # MINIMAL
    ############################################################################
    imports =
        [   # Include the results of the hardware scan.
            ./hardware-configuration.nix

            # home-manager
            inputs.home-manager.nixosModules.default

            # my modules
            ../../modules/configuration_base.nix
            ../../modules/configuration_openvpn.nix
        ];

    ############################################################################
    # DESKTOPS
    ############################################################################

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

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

    hardware = {
        graphics.enable = true;
        # Most wayland compositors need this
        nvidia.modesetting.enable = true;
    };



    ############################################################################
    # USER SETUP
    ############################################################################
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.nolan = {
        isNormalUser = true;
        description = "nolan";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        #  thunderbird
        ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        git
        wget
        xorg.xmodmap
        xorg.xkbcomp
        xorg.xset
        wdisplays
        xwayland
        pulseaudioFull
        brightnessctl
        waybar
        (pkgs.waybar.overrideAttrs (oldAttrs: {
                        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                    })
        )
        openconnect # vpn
        update-systemd-resolved # for openvpn
        dunst # notfications
        libnotify # for dunst
        swww # wallpapers
        kitty # term
        rofi-wayland # app launcher
        rofi-power-menu # power menu
        unzip # unzip archives
        pcmanfm # file manager
        ripgrep # grep tool
        xclip # clipboard access (x)
        wl-clipboard # clipboard access (wayland)
        gscreenshot # screen shots
        htop # sys monitor
        ntfs3g # file system mounting/ ntfsfix
        ghostscript # useful postscript interpreter

        libreoffice # office docs
        spotify # music
        zathura # pdf (minimal)
        okular  # pdf
        imagemagick # image, pdf, and gif utils
        ghostwriter # markdown
        gthumb # photo viewer/edior
        tmux # terminal multiplex
        zoom-us # video conference

        # programming
        libgcc
        gnumake
        cmake
        python3
        filezilla

        # sci ml
        petsc
        eigen
        paraview
        libtorch-bin
        texliveFull
    ];


    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #       enable = true;
    #       enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;


    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

}
