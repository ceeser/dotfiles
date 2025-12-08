# Config for desktop hypervisor

{ lib, config, pkgs, ... }:

{
  options.ceeser.services.virtualisation = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures a hypervisor
      '';
    };
  };

  config = lib.mkIf config.ceeser.services.virtualisation.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
  };
}
