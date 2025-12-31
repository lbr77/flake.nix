{ pkgs, ... }:
let
  pyEnv = pkgs.python313.withPackages (ps: (with ps; [
    pip
    setuptools
    angr
    angrop
    unicorn
    pwntools
    pyshark
  ]) ++ [
    pkgs.headless-ida
  ]);
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    cmake
    curl 
    aria2
    # sketchybar
    
    go
    uv
    ffmpeg
    autojump
    wget
    nodejs
    coreutils-full
    pnpm
    ext4fuse
    perl
    bun
    torrent-vibe
    spicetify-cli
    android-tools
    picgo
    pwntools
    fscan
    codex
    codex-acp
    claude-code
    ripgrep
    binwalk
    openocd
    pandoc
    imagemagick
    xcbeautify
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    terminal-notifier
    swiftformat
    pyEnv
    uv
    unicorn
    javaPackages.compiler.openjdk17
  ];
  environment.variables.EDITOR = "nvim";
  environment.variables.PYTHONPATH = "${pyEnv}/${pyEnv.sitePackages}";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; 
      upgrade = true;
      cleanup = "none";
    };

    masApps = {
    };

    brews = [
      "jadx"
    ];

    casks = [
      "microsoft-edge"
      "visual-studio-code"
      "alt-tab"

      "flowdown"
      "xquartz"
      "mono-mdk"
      "feishu"
      "macfuse" 
      "orbstack"
      "obs"
      "logi-options+"
      "xcodes-app"
      "termius"
      "notion"
      "font-maple-mono-nf"
      "opcode"
      "ghostty"
      "spotify"
      "wechat"
      "telegram"
      "discord"
      "typora"
      "zotero"
      # "picgo"
      "mactex"
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
