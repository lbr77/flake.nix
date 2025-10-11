{
  lib,
  stdenvNoCC,
  fetchzip,
  fetchurl,
  undmg,
  unzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "picgo";
  version = "2.4.0-beta.10";
  
  src = fetchurl {
    url = "https://github.com/Molunerfinn/PicGo/releases/download/v${version}/PicGo-${version}-arm64.dmg";
    sha256 = "sha256-3fWkd68pXPn/vKGjZTYIntFEFHo9ggqZt8jnwePpB6U=";
  };

  unpackCmd = ''
        echo "Attaching DMG..."
        mnt=$(mktemp -d)
        # trap "/usr/bin/hdiutil detach $mnt -force; rm -rf $mnt" EXIT
        /usr/bin/hdiutil attach -nobrowse -readonly $src -mountpoint "$mnt"
        echo Pwd is $(pwd), mnt is $mnt
        echo "Copying *.app to current dir"
        cp -R "$mnt"/*.app $(pwd)
        echo "Copied"
        ls $mnt
        /usr/bin/hdiutil detach $mnt -force;
        ls $(pwd)
        
    '';

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    ls
    cp -r *.app $out/Applications

    # runHook postInstall
  '';

  fixupPhase = ''
    
    rm -rf $mnt
  '';

  meta = with lib; {
    description = "PicGo - A tool for image uploading and management.";
    homepage = "https://github.com/Molunerfinn/PicGo";
    platforms = platforms.darwin;
    license = licenses.unfree;
  };
}
