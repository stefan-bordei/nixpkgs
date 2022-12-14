{
  description = "Home Manager Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    { self, home-manager, nixpkgs, flake-utils, nur, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnsupportedSystem = true;
          allowUnfree = true;
          allowBroken = true;
          permittedInsecurePackages = [
                "openjdk-18+36"
              ];
        };
      };
    in {
      homeConfigurations.zygot = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./modules/alacritty.nix
          #./modules/i3.nix
          ./modules/neovim.nix
          ./modules/packages.nix
          ./home.nix
        ];
      };

      zygot = self.homeConfigurations.zygot.activationPackage;
      defaultPackage.${system} = self.zygot;
    };
}
