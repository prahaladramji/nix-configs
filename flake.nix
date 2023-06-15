{
  description = "Nix System configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      # This overlay allows us to install packages from the unstable branch
      # using unstable.<package-name>
      overlay-unstable = final: prev: {
        unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system};
      };

      pkgsConfig = {
        nixpkgs.overlays = [ overlay-unstable ];
        home.stateVersion = "23.05";
      };

      commonModules = [ ./modules ] ++ [ pkgsConfig ];

      workSystem = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = commonModules ++ [{
          home = {
            username = "prahalad";
            homeDirectory = "/Users/prahalad";
          };
        }];
      };

      chromeOSSystem = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = commonModules ++ [
          ./modules/chromeos.debian.nix
          {
            home = {
              username = "pramji";
              homeDirectory = "/home/pramji";
            };
          }
        ];
      };
    in {
      work = workSystem.activationPackage;
      chromeos = chromeOSSystem.activationPackage;
      defaultPackage.aarch64-darwin = workSystem.activationPackage;
      defaultPackage.x86_64-linux = chromeOSSystem.activationPackage;
    };
}
