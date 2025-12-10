{ pkgs, ... }:
{
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
    jadx
    picgo
    pwntools
    fscan
    codex
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
    python313
    unicorn
    python313Packages.unicorn
    python313Packages.pwntools
    javaPackages.compiler.openjdk17
  ];
  environment.variables.EDITOR = "nvim";

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