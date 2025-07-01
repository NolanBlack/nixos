{ config, pkgs, lib, ... }:

{
	home.file = {
        ".bashrc".source                            = ./../dotfiles/.bashrc;
        ".bashrc_aliases".source                    = ./../dotfiles/.bashrc_aliases;
		".vimrc".source                             = ./../dotfiles/.vimrc;
		".tmux.conf".source                         = ./../dotfiles/.tmux.conf;
		".config/hypr/hyprland.conf".source         = ./../dotfiles/.config/hypr/hyprland.conf;
		".config/waybar/config".source              = ./../dotfiles/.config/waybar/config;
		".config/waybar/toggle_sink.sh".source      = ./../dotfiles/.config/waybar/toggle_sink.sh;
		".config/waybar/style.css".source           = ./../dotfiles/.config/waybar/style.css;
		".config/zathura/zathurarc".source          = ./../dotfiles/.config/zathura/zathurarc;
        ".config/gtk-3.0/gtk.css".source            = ./../dotfiles/.config/gtk.css;
		".config/kitty/curent-theme.conf".source    = ./../dotfiles/.config/kitty/current-theme.conf;
		".config/kitty/kitty.conf".source           = ./../dotfiles/.config/kitty/kitty.conf;
		".config/nvim/after/syntax/c.vim".source    = ./../dotfiles/.config/nvim/syntax/c.vim;
		".config/nvim/colors/gruvbones.lua".source  = ./../dotfiles/.config/nvim/colors/gruvbones.lua;
        # this must be hard coded!
        ".vim/spell/en.utf-8.add".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/.vim/spell/en.utf-8.add";
        # NOT:
        #".vim/spell/en.utf-8.add".source            = ./../../dotfiles/.vim/spell/en.utf-8.add;
        #".vim/spell/en.utf-8.add".source            = config.lib.file.mkOutOfStoreSymlink ./../../dotfiles/.vim/spell/en.utf-8.add;

        # this was error prone...
        # ".config/.." = {
        #     source = ./../../dotfiles;
        #     recursive=true;
        # };
	};
	home.packages = [
	];

	# nvim
	programs.neovim = {
		enable = true;																																										 
		viAlias = true;																																										 
		vimAlias = true;																																									 
		defaultEditor = true;  
		extraConfig = lib.fileContents ./../dotfiles/.config/nvim/init.vim;

		extraPackages = with pkgs; [
			xclip
		];

		plugins = with pkgs.vimPlugins; [
			{
				plugin = nvim-tree-lua;
				type = "lua";
				config = "${builtins.readFile ./../dotfiles/.config/nvim/nvim-tree.lua}";
			}

			YouCompleteMe

            {
                plugin = avante-nvim;
                type = "lua";
				config = "${builtins.readFile ./../dotfiles/.config/nvim/avante.lua}";
            }


			{
				plugin = telescope-nvim;
				type = "lua";
				config = "${builtins.readFile ./../dotfiles/.config/nvim/telescope.lua}";
			}
			telescope-fzf-native-nvim
			{
				plugin = indent-blankline-nvim;
				type = "lua";
				config = "${builtins.readFile ./../dotfiles/.config/nvim/indent-blankline-nvim.lua}";
			}

            # load treesitter and its syntax highlighting rules
			{
				plugin = (nvim-treesitter.withPlugins (p: [
					p.tree-sitter-nix
          			p.tree-sitter-vim
          			p.tree-sitter-bash
          			p.tree-sitter-lua
          			p.tree-sitter-python
          			p.tree-sitter-json
                    # p.tree-sitter-c
                    # p.tree-sitter-cpp
          			p.tree-sitter-markdown
          			p.tree-sitter-latex
				]));
				type = "lua";
				config = "${builtins.readFile ./../dotfiles/.config/nvim/treesitter.lua}";
			}
            nvim-treesitter-parsers.cpp
            nvim-treesitter-parsers.comment


            # multiple colorschemes (the last one will be default)
            {
            	plugin = kanagawa-nvim;
            	type = "lua";
            	config = "${builtins.readFile ./../dotfiles/.config/nvim/kanagawa.lua}";
            }
            {
            	plugin = gruvbox-material-nvim;
            	type = "lua";
            	config = "${builtins.readFile ./../dotfiles/.config/nvim/gruvbox-material.lua}";
            }
            lush-nvim # required for zenbones
            { 
                plugin = zenbones-nvim;
                type = "lua";
                config = "${builtins.readFile ./../dotfiles/.config/nvim/zenbones.lua}";
            }
            {
            	plugin = gruvbox-nvim;
                type = "lua";
                config = "${builtins.readFile ./../dotfiles/.config/nvim/gruvbox.lua}";
            }
		];

	};

	home.sessionVariables = {
		EDITOR = "nvim";
	};
}

