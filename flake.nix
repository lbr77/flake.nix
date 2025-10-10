{
  description = "Nix for libr-macbook-air";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs-darwin,
    darwin,
    home-manager,
    ...
  }: let
    username = "libr";
    useremail = "me@nvme0n1p.dev";
    system = "aarch64-darwin";
    hostname = "libr-macbook-air";

    # 创建自定义包的 overlay
    pkgsOverlay = final: prev: let
      customPkgs = import ./pkgs {pkgs = prev;};
    in
      customPkgs;

    specialArgs =
      inputs
      // {
        inherit username useremail hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        # 添加自定义包 overlay
        {
          nixpkgs.overlays = [pkgsOverlay];
        }

        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/homebrew-mirror.nix
        ./modules/host-users.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ./home;
        }
      ];
    };

    formatter.${system} = nixpkgs-darwin.legacyPackages.${system}.alejandra;
  };
}