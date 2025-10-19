{
  lib,
  stdenv,
  fetchurl,
  gnutar,  # 或者 bsdtar，也可以直接用系统自带 tar
}:

stdenv.mkDerivation rec {
    pname = "codex";
    version = "rust-v0.47.0";

    src = fetchurl {
        url = "https://github.com/openai/codex/releases/download/${version}/codex-aarch64-apple-darwin.tar.gz";
        sha256 = "sha256-00f23kxxncx034dv7prlxpmz2qffl50g3j4jiwzydmyv9g739f1y";
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
