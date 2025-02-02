{ config, pkgs, lib, ... }:

{
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "nolan";
	home.homeDirectory = "/home/nolan";
    imports =
        [   
            ./../../modules/home_base.nix
            ./../../modules/home_theme_dark.nix
        ];

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
        ".bashrc_petsc".source  = ./../../dotfiles/.bashrc_petsc;
        ".bashrc_drexel".source = ./../../dotfiles/.bashrc_drexel;
	};


	# The home.packages option allows you to install Nix packages into your
	# environment.
	home.packages = [
	];


	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "24.05"; # Please read the comment before changing.

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
