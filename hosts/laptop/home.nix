{ config, pkgs, lib, ... }:

{
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "nolan";
	home.homeDirectory = "/home/nolan";

	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		".bashrc".source                            = ./../../dotfiles/.bashrc;
		".vimrc".source                             = ./../../dotfiles/.vimrc;
		".tmux.conf".source                         = ./../../dotfiles/.tmux.conf;
		".config/hypr/hyprland.conf".source         = ./../../dotfiles/.config/hypr/hyprland.conf;
		".config/waybar/config".source              = ./../../dotfiles/.config/waybar/config;
		".config/waybar/toggle_sink.sh".source      = ./../../dotfiles/.config/waybar/toggle_sink.sh;
		".config/waybar/style.css".source           = ./../../dotfiles/.config/waybar/style.css;
		".config/zathura/zathurarc".source          = ./../../dotfiles/.config/zathura/zathurarc;
		".config/gtk-3.0/gtk.css".source            = ./../../dotfiles/.config/gtk.css;
		".config/kitty/curent-theme.conf".source    = ./../../dotfiles/.config/kitty/current-theme.conf;
		".config/kitty/kitty.conf".source           = ./../../dotfiles/.config/kitty/kitty.conf;
	};

	# nvim
	programs.neovim = 
	{
		enable = true;																																										 
		viAlias = true;																																										 
		vimAlias = true;																																									 
		defaultEditor = true;  
		extraConfig = lib.fileContents ./../../dotfiles/.config/nvim/init.vim;

		extraPackages = with pkgs; [
			xclip
		];

		plugins = with pkgs.vimPlugins; [
			{
				plugin = nvim-tree-lua;
				type = "lua";
				config = "${builtins.readFile ./../../dotfiles/.config/nvim/nvim-tree.lua}";
			}

			YouCompleteMe

			{
				plugin = telescope-nvim;
				type = "lua";
				config = "${builtins.readFile ./../../dotfiles/.config/nvim/telescope.lua}";
			}
			telescope-fzf-native-nvim

			{
				plugin = (nvim-treesitter.withPlugins (p: [
					p.tree-sitter-nix
          			p.tree-sitter-vim
          			p.tree-sitter-bash
          			p.tree-sitter-lua
          			p.tree-sitter-python
          			p.tree-sitter-json
                    p.tree-sitter-c
                    p.tree-sitter-cpp
          			p.tree-sitter-markdown
          			p.tree-sitter-latex
				]));
				type = "lua";
				config = "${builtins.readFile ./../../dotfiles/.config/nvim/treesitter.lua}";
			}
                # nvim-treesitter-parsers.cpp

            lush-nvim # required for zenbones
            { 
                plugin = zenbones-nvim;
                    # type = "lua";
                    # config = "${builtins.readFile ./../../dotfiles/.config/nvim/zenbones.lua}";
            }

            {
            	plugin = gruvbox-nvim;
                type = "lua";
                config = "${builtins.readFile ./../../dotfiles/.config/nvim/gruvbox.lua}";
            }
            # {
            # 	plugin = kanagawa-nvim;
            # 	type = "lua";
            # 	config = "${builtins.readFile ./../../dotfiles/.config/nvim/kanagawa.lua}";
            # }
            # {
            # 	plugin = gruvbox-material-nvim;
            # 	type = "lua";
            # 	config = "${builtins.readFile ./../../dotfiles/.config/nvim/gruvbox-material.lua}";
            # }
		];

	};
	# The home.packages option allows you to install Nix packages into your
	# environment.
	home.packages = [
	];

	home.sessionVariables = {
		EDITOR = "nvim";
	};

    # theme
	qt.enable = true;
	qt.platformTheme.name = "gtk";
    qt.style.name = "adwaita-dark";
	qt.style.package = pkgs.adwaita-qt;


	gtk.enable = true;
	gtk.cursorTheme.package = pkgs.bibata-cursors;
    gtk.cursorTheme.name = "Bibata-Original-Classic";
    # gtk.cursorTheme.name = "Bibata-Original-Winter";

	gtk.theme.package = pkgs.adw-gtk3;
	gtk.theme.name = "adw-gtk3";
    
    gtk.iconTheme.package =  pkgs.adwaita-icon-theme;
    gtk.iconTheme.name = "Adwaita-dark";


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
