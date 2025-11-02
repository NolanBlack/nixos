# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
    imports =
        [   
            # MINIMAL
            # Include the results of the hardware scan.
            ./hardware-configuration.nix # minimal

            # home-manager
            inputs.home-manager.nixosModules.default

            ../../modules/configuration_base.nix

            # EXTRA
            ../../modules/configuration_extra.nix
            ../../modules/configuration_hyprland.nix
            ../../modules/configuration_openvpn.nix
        ];

    ############################################################################
    # DESKTOPS
    ############################################################################

    # experimental nvidia setup
    # Graphics Drivers ###########################
    # Enable OpenGL
    hardware.opengl = {
          enable = true;
          driSupport32Bit = true;
    };

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {

        # Modesetting is required.
        modesetting.enable = true;

        # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
        powerManagement.enable = false;
        # Fine-grained power management. Turns off GPU when not in use.
        # Experimental and only works on modern Nvidia GPUs (Turing or newer).
        powerManagement.finegrained = false;

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        # Support is limited to the Turing and later architectures. Full list of
        # supported GPUs is at:
        # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
        # Only available from driver 515.43.04+
        # Do not disable this unless your GPU is unsupported or if you have a good reason to.
        open = false;

        # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
        nvidiaSettings = true;

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        package = config.boot.kernelPackages.nvidiaPackages.stable;

    };

    # ## Graphics END #############################################

    # hardware = {
    #     graphics.enable = true;
    #     # Most wayland compositors need this
    #     nvidia.modesetting.enable = true;
    # };



    ############################################################################
    # USER SETUP
    ############################################################################
    # Define a user account. Don't forget to set a password with ‘passwd’.
    # echo "userpassword"|sudo passwd --stdin username
    users.users.nolan = {
        isNormalUser = true;
        description = "nolan";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };

    users.users.guest = {
        isNormalUser = true;
        description = "guest";
        extraGroups = [ "networkmanager"];
        packages = with pkgs; [
        ];
    };

    ############################################################################
    # SYSTEM
    ############################################################################
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        # programming
        libgcc
        tmux
        gnumake
        cmake
        python3
        filezilla
        eigen
        libtorch-bin
        texliveFull
        paraview
    ];


    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

}
