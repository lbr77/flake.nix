{
  lib,
  stdenvNoCC,
  fetchzip,
}:
let
  # 从 latest-mac-arm64.yml 获取版本和哈希信息
  latestYml = builtins.fetchurl {
    url = "https://github.com/Torrent-Vibe/Torrent-Vibe/releases/latest/download/latest-mac-arm64.yml";
  };

  # 解析 YAML 文件内容
  ymlContent = builtins.readFile latestYml;

  # 提取版本号 (version: v20251008100211)
  versionMatch = builtins.match ".*version: (v[0-9]+).*" ymlContent;
  version = lib.removePrefix "v" (builtins.head versionMatch);

  # 提取 sha512 哈希
  sha512Match = builtins.match ".*sha512: ([A-Za-z0-9+/=]+).*" ymlContent;
  sha512 = builtins.head sha512Match;

  # 提取文件名 (url: Torrent Vibe-darwin-arm64.zip)
  filenameMatch = builtins.match ".*url: ([^\n]+).*" ymlContent;
  filename = builtins.head filenameMatch;
in
stdenvNoCC.mkDerivation rec {
  pname = "torrent-vibe";
  inherit version;

  # 从 GitHub release 下载
  src = fetchzip {
    url = "https://github.com/Torrent-Vibe/Torrent-Vibe/releases/download/v${version}/${filename}";
    # 使用从 YAML 获取的 sha512 哈希
    sha512 = sha512;
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -r *.app $out/Applications

    runHook postInstall
  '';

  meta = with lib; {
    description = "Torrent Vibe - A torrent client for macOS";
    homepage = "https://github.com/Torrent-Vibe/Torrent-Vibe";
    platforms = platforms.darwin;
    license = licenses.unfree;
  };
}
