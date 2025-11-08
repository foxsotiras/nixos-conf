{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom build for xray.
    xray-russia = {
      url = "github:foxsotiras/xray-russia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, xray-russia, ... }@inputs:
    let
      # Basic system information.
      host = "arctic-virt";
      system = "x86_64-linux";

      # Overlays to NixOS configuration from other inputs.
      overlays = [
        (final: prev: {
          stable = nixpkgs-stable.legacyPackages.${system};
        })
        (final: prev: {
          xray = xray-russia.packages.${final.system}.xray-russia;
        })
      ];
    in {
      nixosConfigurations = {
        ${host} = nixpkgs.lib.nixosSystem {
          # Set system type.
          inherit system;

          # Pass flake inputs to configuration files.
          specialArgs = { inherit inputs; };

          # Apply overlays.
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./hosts/${host}/configuration.nix

            # Home manager configuration.
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.johnny = ./hosts/${host}/home.nix;
            }
          ];
        };
      };
    };
}
