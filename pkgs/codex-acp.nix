{
    lib,
    stdenv,
    fetchurl,
    gnutar,
}:

stdenv.mkDerivation rec {
    pname = "codex-acp";
    version = "0.7.4";

    src = fetchurl {
        url = "https://github.com/zed-industries/codex-acp/releases/download/v${version}/codex-acp-${version}-aarch64-apple-darwin.tar.gz";
        sha256 = "sha256-HOjzSEYNs1eM7l4EfOTJZAYnJJxiPd7SnMxdLeYLH6c=";
        # sha256 = lib.fakeSha256;
    };

    nativeBuildInputs = [ gnutar ];

    unpackPhase = ''
        mkdir source
        cd source
        tar -xzf $src
    '';

    installPhase = ''
        mkdir -p $out/bin
        cp codex-acp $out/bin/codex-acp
        chmod +x $out/bin/codex-acp
    '';

    meta = with lib; {
        description = "Codex-ACP prebuilt binary for macOS (Darwin)";
        homepage = "https://github.com/zed-industries/codex-acp";
        license = licenses.mit;
        mainProgram = "codex";
        platforms = platforms.darwin;
    };
}
