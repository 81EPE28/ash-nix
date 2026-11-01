{
  description = "Ash shell package derivation";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSystem = nixpkgs.lib.genAttrs supportedSystems;
    packages = forEachSystem (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.callPackage ./pkgs/by-name/as/ash-shell/package.nix {};
        }
      );
    in
    {
      inherit packages;
      formatter = forEachSystem (system: (import nixpkgs { inherit system; }).nixfmt-rfc-style);
    };
}
