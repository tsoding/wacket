with import <nixpkgs> {}; {
    WacketEnv = stdenv.mkDerivation {
        name = "WacketEnv";
        buildInputs = [ racket wabt ];
    };
}
