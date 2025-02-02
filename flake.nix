{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        ...
    } @ inputs: let
        inherit (self) outputs;
    in {
        # NixOS configuration entrypoint
        # Available through 'nixos-rebuild --flake .#default'
        nixosConfigurations = {
            default = nixpkgs.lib.nixosSystem {
                specialArgs = {inherit inputs outputs;};
                modules = [
                    ./hosts/laptop/configuration.nix
                ];
            };
        };

        # Standalone home-manager configuration entrypoint
        # Available through 'home-manager --flake .#default'
        homeConfigurations = {
            "default" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
                extraSpecialArgs = {inherit inputs outputs;};
                modules = [
                    ./hosts/laptop/home_nolan.nix
                ];
            };
        };
    };
}
