{
    lib,
    stdenvNoCC,
    fetchurl,
    unzip,
}:

stdenvNoCC.mkDerivation rec {
    pname = "IDA Pro";
    version = "9.1";

    src = fetchurl {
        url = "https://vaclive.party/software/ida-pro/releases/download/9.1.250226/ida-pro_91_x64mac.app.zip";
        sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
    nativeBuildInputs = [ unzip ];
    sourceRoot = ".";
    installPhase = ''
        runHook preInstall
        mkdir -p $out/Applications
        ./*.app/Contents/MacOS/installbuilder.sh --mode unattended --unattendedmodeui none --prefix $out/Applications/ida-pro-9.1
        runHook postInstall
    '';
    meta = with lib; {
        description = "IDA Pro leaked prebuilt binary for macOS (Darwin)";
        homepage = "https://hex-rays.com/";
        license = licenses.unfree;
        platforms = platforms.darwin;
    };
}
