{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      export PATH="/Library/TeX/texbin:$PATH"
      [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && source $(brew --prefix)/etc/profile.d/autojump.sh
      source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      # source $(brew --prefix)/share/zsh-completions/
    '';
  };

  home.shellAliases = {
    k = "kubectl";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}