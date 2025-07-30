# nix-cfg
my nixos configuration.

## bootstrap (hopefully works)
```bash
git clone https://github.com/thatonepuggo/nix-cfg ~/.config/nixos
cd ~/.config/nixos
nix develop
nh os switch . && nh home switch -b bak .
```

## thanks
* [spl3g](https://github.com/spl3g/nixfiles) - background
* [lucasew](https://github.com/lucasew/nixcfg/blob/2d61773ff2f18672b1498a5bc17df2c13e2c6800/nix/pkgs/wrapWine.nix) - wrapWine
