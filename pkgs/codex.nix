{
    lib,
    stdenv,
    fetchurl,
    gnutar,
}:

stdenv.mkDerivation rec {
    pname = "codex";
    version = "rust-v0.47.0";

    src = fetchurl {
        url = "https://github.com/openai/codex/releases/download/${version}/codex-aarch64-apple-darwin.tar.gz";
        sha256 = lib.fakeSha256;
    };

    nativeBuildInputs = [ gnutar ];

    unpackPhase = ''
        mkdir source
        cd source
        tar -xzf $src
    '';

    installPhase = ''
        mkdir -p $out/bin
        cp codex-aarch64-apple-darwin $out/bin/codex
        chmod +x $out/bin/codex
    '';

    meta = with lib; {
        description = "Codex prebuilt binary for macOS (Darwin)";
        homepage = "https://github.com/openai/codex";
        license = licenses.mit;
        maintainers = with maintainers; [ Misaka13514 ];
        mainProgram = "codex";
        platforms = platforms.darwin;
    };
}
