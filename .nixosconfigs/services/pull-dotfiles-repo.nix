# Config for neovim

{ config, pkgs, ... }:

{
  imports = [];

  systemd.timers."pull-dotfiles-repo" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Unit = "pull-dotfiles-repo.service";
    };
  };

  systemd.services."pull-dotfiles-repo" = {
    script = ''
      /run/current-system/sw/bin/git --git-dir=/home/ceeser/.dotfilesrepo --work-tree=/home/ceeser/ pull
    '';
    serviceConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
