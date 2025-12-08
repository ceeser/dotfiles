
# Config for desktop hypervisor

{ lib, config, pkgs, ... }:

{
  options.ceeser.desktops.cosmic = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures the cosmic desktop
      '';
    };
  };

  config = lib.mkIf config.ceeser.desktops.cosmic.enable {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;
  };
}
