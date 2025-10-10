{
  lib,
  stdenvNoCC,
  fetchzip,
  fetchurl,
  undmg,
  unzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "torrent-vibe";
  version = "v20251008100211";
  
  src = fetchurl {
    url = "https://github.com/Torrent-Vibe/Torrent-Vibe/releases/download/${version}/Torrent.Vibe-darwin-arm64.zip";
    sha256 = "sha256-Pp8b54Ce2M1yOIuiBukgMxJ/JPXCvqtWl+nnI7UEK4E=";
  };

  nativeBuildInputs = [ unzip ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    ls
    cp -r *.app $out/Applications

    runHook postInstall
  '';

  meta = with lib; {
    description = "Torrent Vibe";
    homepage = "https://github.com/Torrent-Vibe/Torrent-Vibe";
    platforms = platforms.darwin;
    license = licenses.unfree;
  };
}
