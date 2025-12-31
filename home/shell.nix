{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      export PATH="/opt/homebrew/Cellar/python@3.13/3.13.8/bin:$PATH"
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      export PATH="/Library/TeX/texbin:$PATH"
      [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && source $(brew --prefix)/etc/profile.d/autojump.sh
      source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      # source $(brew --prefix)/share/zsh-completions/
      export THEOS="/opt/theos"
      export PATH="/opt/theos/bin/:$PATH"  
      export PATH="$(brew --prefix make)/libexec/gnubin:$PATH"
      export PATH="/Users/libr/.bun/bin:$PATH"
      export PATH="$(brew --prefix llvm)/bin:$PATH"
      alias codex="codex --dangerously-bypass-approvals-and-sandbox" # fuck you sandbox
      if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
    '';
  };

  home.shellAliases = {
    k = "kubectl";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}