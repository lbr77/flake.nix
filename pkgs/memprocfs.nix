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
        mkdir -p $out/bin $out/lib/plugins $out/share/memprocfs

        # 主程序
        cp memprocfs $out/bin/
        chmod +x $out/bin/memprocfs

        # 动态库
        cp leechcore_ft601_driver_macos.dylib $out/lib/
        cp leechcore.dylib $out/lib/
        cp libftd3xx.dylib $out/lib/
        cp libMSCompression.dylib $out/lib/
        cp libpdbcrust.dylib $out/lib/
        cp vmm.dylib $out/lib/
        cp vmmyara.dylib $out/lib/

        # 插件
        cp plugins/m_vmemd.dylib $out/lib/plugins/

        # 其他资源文件
        cp info.db memprocfs.icns vmmdll.h LICENSE.txt $out/share/memprocfs/
        cp license_*.txt license_info_all.txt $out/share/memprocfs/
    '';
    postInstall = ''
        wrapProgram $out/bin/memprocfs \
        --set DYLD_LIBRARY_PATH "$out/lib"
    '';

    meta = with lib; {
        description = "MemprocFS prebuilt binary for macOS (Darwin)";
        homepage = "https://github.com/openai/codex";
        license = licenses.mit;
        mainProgram = "memprocfs";
        platforms = platforms.darwin;
    };
}
