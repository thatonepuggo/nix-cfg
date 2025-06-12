rec {
  pow = base: exponent: builtins.foldl' (x: _: x * base) 1 (builtins.genList (x: x) exponent);
  bitShiftLeft = x: n: x * (pow 2 n);
  bitShiftRight = x: n: builtins.floor (x / (pow 2 n));
}
