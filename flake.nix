{
  description = "qFioofa-Ghostty — personal Ghostty terminal config as a flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      # Symlinks ./src to ~/.config/ghostty (see scripts/deploy.sh), optionally
      # installing the ghostty package. Gated behind programs.qfioofa-ghostty.enable.
      homeManagerModules.default = import ./nix/hm-module.nix { inherit self; };
      homeManagerModules.qfioofa-ghostty = self.homeManagerModules.default;

      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
