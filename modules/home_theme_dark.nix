{ config, pkgs, lib, ... }:

{
    # theme
	qt.enable = true;
	qt.platformTheme.name = "gtk";
    qt.style.name = "adwaita-dark";
	qt.style.package = pkgs.adwaita-qt;


	gtk.enable = true;
	gtk.cursorTheme.package = pkgs.bibata-cursors;
    gtk.cursorTheme.name = "Bibata-Original-Classic";
    # gtk.cursorTheme.name = "Bibata-Original-Winter";
    # gtk.cursorTheme.name = "Bibata-Modern-Ice";

	gtk.theme.package = pkgs.adw-gtk3;
	gtk.theme.name = "adw-gtk3";
    
    gtk.iconTheme.package =  pkgs.adwaita-icon-theme;
    gtk.iconTheme.name = "Adwaita-dark";
}

