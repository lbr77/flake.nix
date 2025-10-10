{ pkgs, ... }:
{
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    neovim
    git
    cmake
    uv
    wget
    nodejs
    pnpm
    bun

    # 从 pkgs 文件夹导入的自定义包
    # 取消下面的注释来安装自定义应用（需要先配置正确的下载地址和 sha256）
    torrent-vibe
  ];
  environment.variables.EDITOR = "nvim";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
    };

    # taps = [];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "aria2" # download tool
    ];

    casks = [
      "google-chrome"
      "visual-studio-code"
      "alt-tab"
      "claude-code"
      "feishu"
      "obs"
      "logi-options+"
      "termius"
      "notion"
      "font-maple-mono-nf"
      "opcode"
      "ghostty"
      "spotify"
      "wechat"
      "telegram"
      "discord"
      "wetype"
      "winbox"
      "iina" # video player
      "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      "stats" # beautiful system monitor
      "httpie-desktop" # http client
      "wireshark-app" # network analyzer
    ];
  };
}