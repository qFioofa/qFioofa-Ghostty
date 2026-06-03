{
  description = "qFioofa Ghostty config — Home Manager module";

  # See scripts/deploy.sh: src/ is the config root, target is ~/.config/ghostty.
  outputs = { self }: {
    homeManagerModules.default = { config, lib, pkgs, ... }: {
      xdg.configFile."ghostty" = {
        recursive = true;
        source = ./src;
      };
    };
  };
}
