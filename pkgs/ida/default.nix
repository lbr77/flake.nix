{
    lib,
    stdenvNoCC,
    fetchurl,
    unzip,
    python3,
    username,
    useremail,
}:

stdenvNoCC.mkDerivation rec {
    pname = "IDA Pro";
    version = "9.1";

    src = fetchurl {
        url = "https://vaclive.party/software/ida-pro/releases/download/9.1.250226/ida-pro_91_armmac.app.zip";
        sha256 = "sha256-jZF6lelsic4ASEguO6W9WW1P5/t3AOe/4F7GIfr1NaA=";
    };
    nativeBuildInputs = [ unzip python3 ];
    sourceRoot = ".";
    installPhase = ''
        runHook preInstall
        mkdir -p $out/Applications
        echo "Installing IDA Pro..."
        ./ida-pro_91_armmac.app/Contents/MacOS/installbuilder.sh --mode unattended --unattendedmodeui none --prefix $out/Applications/IDA\ Professional\ 9.1.app
        ls $out

        runHook postInstall
    '';
    postInstall = ''
        # patch to cracked
        function replace() {
            declare -r dom=$( hex $2 )
            declare -r sub=$( hex $3 )
            sudo perl -0777pi -e 'BEGIN{$/=\1e8} s|'$dom'|'$sub'|gs' "$1"
            return
        }
        function prep() {
            xattr -cr "$1"
            xattr -r -d com.apple.quarantine "$1"
            codesign --force --deep --sign - "$1"
        }
        # backup
        echo "Backing up original files..."
        cp "$out/Applications/IDA Professional 9.1.app/Contents/MacOS/libida.dylib" \
            "$out/Applications/IDA Professional 9.1.app/Contents/MacOS/libida.dylib.bak"
        cp "$out/Applications/IDA Professional 9.1.app/Contents/MacOS/libida32.dylib" \
            "$out/Applications/IDA Professional 9.1.app/Contents/MacOS/libida32.dylib.bak"
        cp "$out/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hv" \
            "$out/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hv.bak"
        cp "$out/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hvui" \
            "$out/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hvui.bak"
        echo "Patching files..."
        echo "Patching libida.dylib..."
        replace "$out/Applications/IDA Professional 9.1.app/Contents/MacOS/libida.dylib" \
            'EDFD425CF978546E8911225884436C57140525650BCF6EBFE80EDBC5FB1DE68F4C66C29CB22EB668788AFCB0ABBB718044584B810F8970CDDF227385F75D5DDDD91D4F18937A08AA83B28C49D12DC92E7505BB38809E91BD0FBD2F2E6AB1D2E33C0C55D5BDDD478EE8BF845FCEF3C82B9D2929ECB71F4D1B3DB96E3A8E7AAF93' \
            'EDFD42CBF978546E8911225884436C57140525650BCF6EBFE80EDBC5FB1DE68F4C66C29CB22EB668788AFCB0ABBB718044584B810F8970CDDF227385F75D5DDDD91D4F18937A08AA83B28C49D12DC92E7505BB38809E91BD0FBD2F2E6AB1D2E33C0C55D5BDDD478EE8BF845FCEF3C82B9D2929ECB71F4D1B3DB96E3A8E7AAF93'
        replace "$out/Applications/IDA Professional 9.1.app/Contents/MacOS/libida.dylib" \
            '602E40F900013FD6A0040034' \
            '602E40F900013FD625000014'
        replace "/Applications/IDA Professional 9.1.app/Contents/MacOS/libida.dylib" \
            'F800000085C00F8492' \
            'F800000085C090E992'
        echo "Patching libida32.dylib..."
        replace "/Applications/IDA Professional 9.1.app/Contents/MacOS/libida32.dylib" \
            'EDFD425CF978546E8911225884436C57140525650BCF6EBFE80EDBC5FB1DE68F4C66C29CB22EB668788AFCB0ABBB718044584B810F8970CDDF227385F75D5DDDD91D4F18937A08AA83B28C49D12DC92E7505BB38809E91BD0FBD2F2E6AB1D2E33C0C55D5BDDD478EE8BF845FCEF3C82B9D2929ECB71F4D1B3DB96E3A8E7AAF93' \
            'EDFD42CBF978546E8911225884436C57140525650BCF6EBFE80EDBC5FB1DE68F4C66C29CB22EB668788AFCB0ABBB718044584B810F8970CDDF227385F75D5DDDD91D4F18937A08AA83B28C49D12DC92E7505BB38809E91BD0FBD2F2E6AB1D2E33C0C55D5BDDD478EE8BF845FCEF3C82B9D2929ECB71F4D1B3DB96E3A8E7AAF93'
        replace "/Applications/IDA Professional 9.1.app/Contents/MacOS/libida32.dylib" \
            '602E40F900013FD6A0040034' \
            '602E40F900013FD625000014'
        replace "/Applications/IDA Professional 9.1.app/Contents/MacOS/libida32.dylib" \
            'F800000085C00F8492' \
            'F800000085C090E992'
        echo "Patching hv..."
        replace "/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hvui" \
            'EDFD425CF978546E8911225884436C57140525650BCF6EBFE80EDBC5FB1DE68F4C66C29CB22EB668788AFCB0ABBB718044584B810F8970CDDF227385F75D5DDDD91D4F18937A08AA83B28C49D12DC92E7505BB38809E91BD0FBD2F2E6AB1D2E33C0C55D5BDDD478EE8BF845FCEF3C82B9D2929ECB71F4D1B3DB96E3A8E7AAF93' \
            'EDFD42CBF978546E8911225884436C57140525650BCF6EBFE80EDBC5FB1DE68F4C66C29CB22EB668788AFCB0ABBB718044584B810F8970CDDF227385F75D5DDDD91D4F18937A08AA83B28C49D12DC92E7505BB38809E91BD0FBD2F2E6AB1D2E33C0C55D5BDDD478EE8BF845FCEF3C82B9D2929ECB71F4D1B3DB96E3A8E7AAF93'
        replace "/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hvui" \
            '602E40F900013FD6A0040034' \
            '602E40F900013FD625000014'
        replace "/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hvui" \
            'F800000085C00F8492' \
            'F800000085C090E992'
        echo "Patch Completed."
        echo "Resigning patched files..."

        prep "/Applications/IDA Professional 9.1.app"
        prep "/Applications/IDA Professional 9.1.app/Contents/MacOS/libida.dylib"
        prep "/Applications/IDA Professional 9.1.app/Contents/MacOS/libida32.dylib"
        prep "/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hv"
        prep "/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app/Contents/MacOS/hvui"
        prep "/Applications/IDA Professional 9.1.app/Contents/Resources/hvui.app"

        echo "Done."
        echo "Generating license file..."
        ${python3}/bin/python3 ${./patch.py} ${username} ${useremail}
    '';
    meta = with lib; {
        description = "IDA Pro leaked prebuilt binary for macOS (Darwin)";
        homepage = "https://hex-rays.com/";
        license = licenses.unfree;
        platforms = platforms.darwin;
    };
}
