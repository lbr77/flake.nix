{
    lib,
    stdenv,
    fetchurl,
    unzip,
    makeWrapper
}:

stdenv.mkDerivation rec {
    pname = "MemProcFS";
    version = "v5.16";

    src = fetchurl {
        url = "https://github.com/ufrisk/MemProcFS/releases/download/${version}/MemProcFS_files_and_binaries_${version}.3-macOS-20251016.zip";
        sha256 = "sha256-BO+unIlpf71wsrqxJJns/MjQ4GuespfTwrE4fQbtdXA=";
    };

    nativeBuildInputs = [ unzip makeWrapper ];

    unpackPhase = ''
        mkdir source
        cd source
        unzip $src || true
    '';

    installPhase = ''
        mkdir -p $out/share/memprocfs $out/bin

        # 全部内容保持原始结构
        cp -r ./* $out/share/memprocfs/

        # 建立符号链接
        ln -s ../share/memprocfs/memprocfs $out/bin/memprocfs

        chmod +x $out/share/memprocfs/memprocfs
    '';


    meta = with lib; {
        description = "MemprocFS prebuilt binary for macOS (Darwin)";
        homepage = "https://github.com/ufrisk/MemProcFS";
        license = licenses.mit;
        mainProgram = "memprocfs";
        platforms = platforms.darwin;
    };
}
