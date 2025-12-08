# Config for neovim

{ lib, config, pkgs, ... }:

{
  options.ceeser.services.pulldotfiles = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs a systemd service to pull dotfiles periodically
      '';
    };
  };

  config = lib.mkIf config.ceeser.services.pulldotfiles.enable {
    systemd.timers."pull-dotfiles-repo" = {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Unit = "pull-dotfiles-repo.service";
      };
    };

    systemd.services."pull-dotfiles-repo" = {
      script = ''
        test "$(/run/current-system/sw/bin/git --git-dir=/home/ceeser/.dotfilesrepo --work-tree=/home/ceeser/ branch --show-current)" = "main"
        /run/current-system/sw/bin/git --git-dir=/home/ceeser/.dotfilesrepo --work-tree=/home/ceeser/ pull --ff-only
      '';
      serviceConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
