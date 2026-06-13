# Home Manager module: applies the qFioofa-Ghostty config declaratively.
#
# Usage (flake): add this repo's input, then in your home-manager config:
#
#   imports = [ qfioofa-ghostty.homeManagerModules.default ];
#   programs.qfioofa-ghostty.enable = true;
#
# It symlinks ./src to ~/.config/ghostty (the same target scripts/deploy.sh
# writes) so the config, themes, and shaders are managed declaratively. Set
# `package` to also install Ghostty itself.
{ self }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.qfioofa-ghostty;
in
{
  options.programs.qfioofa-ghostty = {
    enable = lib.mkEnableOption "the qFioofa-Ghostty configuration";

    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
      defaultText = lib.literalExpression "null";
      example = lib.literalExpression "pkgs.ghostty";
      description = ''
        Ghostty package to install alongside the config. Leave null (the
        default) to manage only the config files and get Ghostty elsewhere
        (e.g. a system-level package), matching scripts/deploy.sh.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.optional (cfg.package != null) cfg.package;

    xdg.configFile."ghostty" = {
      recursive = true;
      source = self + "/src";
    };
  };
}
