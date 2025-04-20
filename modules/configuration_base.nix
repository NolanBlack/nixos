{ config, pkgs, inputs, ... }:

{
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

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;


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

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # setup flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    ############################################################################
    # Programs
    ############################################################################

    # Install firefox.
    programs.firefox.enable = true;

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

    # nix-ld (for running
    # Precompiled binaries that were not created for NixOS usually have a
    # so-called link-loader hardcoded into them. On Linux/x86_64 this is for
    # example /lib64/ld-linux-x86-64.so.2. for glibc. NixOS, on the other
    # hand, usually has its dynamic linker in the glibc package in the Nix
    # store and therefore cannot run these binaries. Nix-ld provides a shim
    # layer for these types of binaries. It is installed in the same location
    # where other Linux distributions install their link loader, ie.
    # /lib64/ld-linux-x86-64.so.2 and then loads the actual link loader as
    # specified in the environment variable NIX_LD. In addition, it also
    # accepts a colon-separated path from library lookup paths in
    # NIX_LD_LIBRARY_PATH. This environment variable is rewritten to
    # LD_LIBRARY_PATH before passing execution to the actual ld. This allows
    # you to specify additional libraries that the executable needs to run.
    programs.nix-ld.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #       enable = true;
    #       enableSSHSupport = true;
    # };

    ############################################################################
    # Services
    ############################################################################

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Configure keymap in X11
    services.xserver.autoRepeatDelay = 250;
    services.xserver.autoRepeatInterval = 60;
    services.xserver.xkb = {
        layout = "us";
        variant = "";
        # options = "caps:swapescape"; # quick and dirty caps -> escape, prefer to use keyd
    };
    console.useXkbConfig = true;

    # keyd for good remapping
    services.keyd = {
        enable = true;
            keyboards = {
                # The name is just the name of the configuration file, it does not really matter
                default = {
                    ids = [ "*" ]; # what goes into the [id] section, here we select all keyboards
                    # Everything but the ID section:
                    settings = {
                        # The main layer, if you choose to declare it in Nix
                        main = { # you might need to also enclose the key in quotes if it contains non-alphabetical symbols
                            # capslock mapped to escape (when pressed), meta (when held)
                            capslock = "overload(meta, escape)";
                        };
                        otherlayer = {};
                    };
                    extraConfig = ''
                        # put here any extra-config, e.g. you can copy/paste here directly a configuration, just remove the ids part
                    '';
                };
            };
    };

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

    ############################################################################
    # Packages
    ############################################################################
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
        openconnect # vpn
        unzip # unzip archives
        ripgrep # grep tool
        xclip # clipboard access (x)
        wl-clipboard # clipboard access (wayland)
        htop # sys monitor
        ntfs3g # file system mounting/ ntfsfix
        ghostscript # useful postscript interpreter
        imagemagick # image, pdf, and gif utils
        fzf # cl util
        bat # colored cat

    ];

}

