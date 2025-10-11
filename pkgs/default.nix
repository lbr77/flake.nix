{pkgs, ...}: {
  # 这里导入所有自定义包
  # 示例：从 GitHub release 下载的应用
  torrent-vibe = pkgs.callPackage ./torrent-vibe.nix {};
  picgo = pkgs.callPackage ./picgo.nix {};
}
