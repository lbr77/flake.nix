{
    lib,
    stdenv,
    fetchurl,
    gnutar,
}:

stdenv.mkDerivation rec {
    pname = "codex";
    version = "rust-v0.63.0";

    src = fetchurl {
        url = "https://github.com/openai/codex/releases/download/${version}/codex-aarch64-apple-darwin.tar.gz";
        sha256 = "sha256-p6Zsj+EyxWNM3/zLefO7Z+p9SH2dEFLoGPsLpWp+HoY=";
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
        mainProgram = "codex";
        platforms = platforms.darwin;
    };
}
