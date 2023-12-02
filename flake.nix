{
  description = "Advent of Code 2023 in ChezScheme";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          day01 = pkgs.stdenv.mkDerivation rec {
              name = "day01";
              src = ./.;
              propagatedBuildInputs = [
                pkgs.chez-racket
              ];
              buildPhase = ''
                echo "\"$out/etc/\"" > day01/prefix.ss
                mkdir -p $out/bin
                mkdir -p $out/etc
                ${pkgs.chez-racket}/bin/scheme --script compile.scm $out/bin/${name}
                cp day01/input.txt $out/etc/input.txt
              '';
              installPhase = ''
                chmod +x $out/bin/${name}
              '';
            };
        };

        devShells = {
          default = pkgs.mkShell {
            # Development tools
            packages = [
              pkgs.chez-racket
            ];

            # Tools from packages
            #inputsFrom = self.packages;
          };
        };
      });
}
