{ lib, ... }:
let
  # Homebrew Mirror
  homebrew_mirror_env = {
    HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };
in
{
  environment.variables = homebrew_mirror_env;

  system.activationScripts.homebrew.text =
    let
      env_script = lib.attrsets.foldlAttrs (acc: name: value: acc + "\nexport ${name}=${value}") "" homebrew_mirror_env;
    in
    lib.mkBefore ''
      echo >&2 '${env_script}'
      ${env_script}
    '';
}