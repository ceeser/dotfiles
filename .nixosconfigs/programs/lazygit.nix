# Config for lazygit

{ config, pkgs, ... }:

{
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
}
