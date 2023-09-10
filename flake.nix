{
  description = "FLOKI";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes"];
    substituters = "https://cache.nixos.org/";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, home-manager, ...}@inputs: {
    nixosConfigurations = {
      nixussy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./nixos/configuration.nix ];
      };
    };
  };
}
