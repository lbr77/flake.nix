{ 
  pkgs, 
  username,
  useremail,
  ...
}: {
  # 这里导入所有自定义包
  # 示例：从 GitHub release 下载的应用
  torrent-vibe = pkgs.callPackage ./torrent-vibe.nix {};
  picgo = pkgs.callPackage ./picgo.nix {};
  fscan = pkgs.callPackage ./fscan.nix {};
  codex = pkgs.callPackage ./codex.nix {};
  memprocfs = pkgs.callPackage ./memprocfs.nix {};
  ida = pkgs.callPackage ./ida/default.nix {
    username = username;
    useremail = useremail;
  };
}
