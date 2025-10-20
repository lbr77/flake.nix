{
    lib,
    stdenv,
    fetchurl,
    unzip,
}:

stdenv.mkDerivation rec {
    pname = "MemProcFS";
    version = "v5.16";
    
    src = fetchurl {
        url = "https://github.com/ufrisk/MemProcFS/releases/download/${version}/MemProcFS_files_and_binaries_${version}.3-macOS-20251016.zip";
        sha256 = lib.fakeSha256;
    };

    nativeBuildInputs = [ unzip ];

    unpackPhase = ''
        mkdir source
        cd source
        unzip $src
    '';

    installPhase = ''
        mkdir -p $out/bin
        cp codex-aarch64-apple-darwin $out/bin/codex
        chmod +x $out/bin/codex
    '';

    meta = with lib; {
        description = "MemprocFS prebuilt binary for macOS (Darwin)";
        homepage = "https://github.com/openai/codex";
        license = licenses.mit;
        mainProgram = "memprocfs";
        platforms = platforms.darwin;
    };
}
