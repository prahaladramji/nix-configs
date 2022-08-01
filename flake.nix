{
  description = "Nix System configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
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
        nixpkgs.config = { allowUnfreePredicate = (pkg: true); };
        nixpkgs.overlays = [ overlay-unstable ];
      };

      commonModules = [ ./modules ] ++ [ pkgsConfig ];

      workSystem = home-manager.lib.homeManagerConfiguration {
        configuration.imports = commonModules;
        system = "aarch64-darwin";
        homeDirectory = "/Users/prahalad";
        username = "prahalad";
        stateVersion = "22.05";
      };

      chromeOSSystem = home-manager.lib.homeManagerConfiguration {
        configuration.imports = commonModules
          ++ [ ./modules/chromeos.debian.nix ];
        system = "x86_64-linux";
        homeDirectory = "/home/pramji";
        username = "pramji";
        stateVersion = "22.05";
      };
    in {
      work = workSystem.activationPackage;
      chromeos = chromeOSSystem.activationPackage;
      defaultPackage.aarch64-darwin = workSystem.activationPackage;
      defaultPackage.x86_64-linux = chromeOSSystem.activationPackage;
    };
}
