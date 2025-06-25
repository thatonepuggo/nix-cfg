{ pkgs, lib, ... }: let
  inherit (pkgs) stdenv callPackage;
  mkWallpaper =
    {
      name,
      src,
      description,
      license ? lib.licenses.free,
    }:

    let
      pkg = stdenv.mkDerivation {
        inherit name src;

        dontUnpack = true;

        installPhase = ''
                  runHook preInstall

                  # GNOME
                  mkdir -p $out/share/backgrounds/custom
                  ln -s $src $out/share/backgrounds/custom/${builtins.baseNameOf src}

                  mkdir -p $out/share/gnome-background-properties/
                  cat <<EOF > $out/share/gnome-background-properties/${name}.xml
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
          <wallpapers>
            <wallpaper deleted="false">
              <name>${name}</name>
              <filename>${src}</filename>
              <options>zoom</options>
              <shade_type>solid</shade_type>
              <pcolor>#ffffff</pcolor>
              <scolor>#000000</scolor>
            </wallpaper>
          </wallpapers>
          EOF

                  # TODO: is this path still needed?
                  mkdir -p $out/share/artwork/gnome
                  ln -s $src $out/share/artwork/gnome/${builtins.baseNameOf src}

                  # KDE
                  mkdir -p $out/share/wallpapers/${name}/contents/images
                  ln -s $src $out/share/wallpapers/${name}/contents/images/${builtins.baseNameOf src}
                  cat >>$out/share/wallpapers/${name}/metadata.desktop <<_EOF
          [Desktop Entry]
          Name=${name}
          X-KDE-PluginInfo-Name=${name}
          _EOF

                  runHook postInstall
        '';

        passthru = {
          gnomeFilePath = "${pkg}/share/backgrounds/custom/${builtins.baseNameOf src}";
          kdeFilePath = "${pkg}/share/wallpapers/${name}/contents/images/${builtins.baseNameOf src}";
        };

        meta = with lib; {
          inherit description license;
          platforms = platforms.all;
        };
      };
    in
    pkg;
in {
  owlcat = mkWallpaper {
    name = "owlcat";
    description = ":3";
    src = ./owlcat.png;
  };
}
