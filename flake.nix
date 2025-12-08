{
  description = "Nix for libr-macbook-air";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
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
      inherit (prev) lib;
      pkgsDir = ./pkgs;
      entries = builtins.readDir pkgsDir;
      entryNames = builtins.attrNames entries;
      pkgArgs = {
        inherit username useremail;
      };
      callPkg = lib.callPackageWith (prev // pkgArgs);

      nixFiles =
        builtins.listToAttrs
        (map
          (file: {
            name = lib.removeSuffix ".nix" file;
            value = callPkg (pkgsDir + "/${file}") {};
          })
          (lib.filter (name: entries.${name} == "regular" && lib.hasSuffix ".nix" name && name != "default.nix") entryNames));

      nixDirs =
        builtins.listToAttrs
        (map
          (dir: {
            name = dir;
            value = callPkg (pkgsDir + "/${dir}") {};
          })
          (lib.filter (name: entries.${name} == "directory" && builtins.pathExists (pkgsDir + "/${name}/default.nix")) entryNames));
    in
      nixFiles // nixDirs;

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
