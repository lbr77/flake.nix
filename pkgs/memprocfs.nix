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
        for bin in $out/bin/memprocfs; do
            echo "fixing $bin"
            install_name_tool -add_rpath "$out/lib" "$bin"
        done

        for libfile in $out/lib/*.dylib; do
            echo "🔧 fixing $libfile"
            install_name_tool -id "$out/lib/$(basename $libfile)" "$libfile"
            for dep in $out/lib/*.dylib; do
            name=$(basename $dep)
            install_name_tool -change "@rpath/$name" "$out/lib/$name" "$libfile" 2>/dev/null || true
            done
        done

        for dep in $out/lib/*.dylib; do
            name=$(basename $dep)
            install_name_tool -change "@rpath/$name" "$out/lib/$name" "$out/bin/memprocfs" 2>/dev/null || true
        done
    '';

    meta = with lib; {
        description = "MemprocFS prebuilt binary for macOS (Darwin)";
        homepage = "https://github.com/openai/codex";
        license = licenses.mit;
        mainProgram = "memprocfs";
        platforms = platforms.darwin;
    };
}
