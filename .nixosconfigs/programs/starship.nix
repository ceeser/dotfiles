# Config for neovim

{ lib, config, pkgs, ... }:

{
  options.ceeser.programs.starship = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures starship
      '';
    };
  };

  config = lib.mkIf config.ceeser.programs.starship.enable {
    programs.starship = {
      enable = true;
      settings = pkgs.lib.importTOML ../../.config/starship.toml;
    };
  };
}
