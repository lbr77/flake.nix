{
  lib,
  stdenvNoCC,
  fetchurl,
  xar,
  cpio,
}:

stdenvNoCC.mkDerivation rec {
  pname = "IDA Pro";
  version = "9.1";

  src = fetchurl {
    url = "https://vaclive.party/software/ida-pro/releases/download/9.1.250226/ida-pro_91_x64mac.app.zip";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };


  meta = with lib; {
    description = "IDA Pro leaked prebuilt binary for macOS (Darwin)";
    homepage = "https://hex-rays.com/";
    license = licenses.unfree;
    platforms = platforms.darwin;
  };
}
