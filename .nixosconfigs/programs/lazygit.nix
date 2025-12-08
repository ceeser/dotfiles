# Config for lazygit

{ lib, config, pkgs, ... }:

{
  options.ceeser.programs.lazygit = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures lazygit
      '';
    };
  };

  config = lib.mkIf config.ceeser.programs.lazygit.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          authorColors = {
            "*" = "#b4befe";
          };
          nerdFontsVersion = "3";
          theme = {
            activeBorderColor = [
              "#b4befe"
              "bold"
            ];
            inactiveBorderColor = [
              "#a6adc8"
            ];
            optionsTextColor = [
              "#89b4fa"
            ];
            selectedLineBgColor = [
              "#313244"
            ];
            cherryPickedCommitBgColor = [
              "#45475a"
            ];
            cherryPickedCommitFgColor = [
              "#b4befe"
            ];
            unstagedChangesColor = [
              "#f38ba8"
            ];
            defaultFgColor = [
              "#cdd6f4"
            ];
            searchingActiveBorderColor = [
              "#f9e2af"
            ];
          };
        };
        notARepository = "quit";
        update = {
          method = "never";
        };
      };
    };
  };
}
