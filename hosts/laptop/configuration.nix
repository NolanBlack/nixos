# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
    ############################################################################
    # MINIMAL
    ############################################################################
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
            inputs.home-manager.nixosModules.default
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;    # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # System
    # Set your time zone.
    time.timeZone = "America/Denver";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver.autoRepeatDelay = 250;
    services.xserver.autoRepeatInterval = 60;
    services.xserver.xkb = {
        layout = "us";
        variant = "";
        options = "caps:swapescape";
    };
    console.useXkbConfig = true;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Install firefox.
    programs.firefox.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # setup flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
        pkgs.xdg-desktop-portal-kde
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

    # OPENVPN
    # OPENVPN.optionA run via system
    # enable openvpn
    #services.openvpn.servers = {
    #    officeVPN  = {
    #        config = '' config /home/nolan/Downloads/vpnconfig_cert.ovpn '';
    #        updateResolvConf = true;
    #    };
    #};

    # OPENVPN.optionB enable systemd-resolved for vpn
    # run via `sudo openvpn --config path/to/config`
    # may need to run 
    #       systemctl enable systemd-resolved.service
    #       systemctl start systemd-resolved.service
    services.resolved = {
        enable = true;
    };

    # Need to link to libexec to have update-systemd-resolved
    environment.pathsToLink = [ "/libexec" ];



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
        openvpn # vpn
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
    # neovim
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
    };


    # fonts
    fonts.packages = with pkgs; [
        font-awesome
        nerd-fonts.symbols-only
        #(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
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
