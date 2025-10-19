{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    cmake
    uv
    ffmpeg
    wget
    nodejs
    pnpm
    bun
    torrent-vibe
    spicetify-cli
    android-tools
    jadx
    picgo
    pwntools
    swiftformat
    fscan
    codex
    claude-code
  ];
  environment.variables.EDITOR = "nvim";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; 
      upgrade = true;
      cleanup = "zap";
    };

    masApps = {
    };

    brews = [
      "wget" 
      "curl" 
      "cmake" # Fuck you apple. 
      "aria2"
      "go"
      "rsync"
      "autojump"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
      "zsh-completions"
      "terminal-notifier"

      "python@3.13"
      "codex"
      "unicorn"

    ];

    casks = [
      "google-chrome"
      "visual-studio-code"
      "alt-tab"
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