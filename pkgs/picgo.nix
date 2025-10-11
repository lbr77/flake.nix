{
  lib,
  stdenvNoCC,
  fetchzip,
  fetchurl,
  undmg,
  unzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "picgo";
  version = "2.4.0-beta.10";
  
  src = fetchurl {
    url = "https://github.com/Molunerfinn/PicGo/releases/download/v${version}/PicGo-${version}-arm64.dmg";
    sha256 = "sha256-Pp8b54Ce2M1yOIuiBukgMxJ/JPXCvqtWl+nnI7UEK4E=";
  };

  nativeBuildInputs = [ undmg ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    ls
    cp -r *.app $out/Applications

    runHook postInstall
  '';

  meta = with lib; {
    description = "PicGo - A tool for image uploading and management.";
    homepage = "https://github.com/Molunerfinn/PicGo";
    platforms = platforms.darwin;
    license = licenses.unfree;
  };
}
