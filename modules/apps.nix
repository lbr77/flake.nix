{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    cmake
    uv
    wget
    nodejs
    pnpm
    bun
    # custom

    torrent-vibe
    picgo
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

      "autojump"
      "zsh-autosuggestions"
      "zsh-syntax-highlighting"
      "zsh-completions"
      "terminal-notifier"
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