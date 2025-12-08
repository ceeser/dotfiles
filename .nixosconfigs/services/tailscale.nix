
# Config for tailscale

{ lib, config, pkgs, ... }:

{
  options.ceeser.services.tailscale = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures tailscale
      '';
    };
  };

  config = lib.mkIf config.ceeser.services.tailscale.enable {
    services.tailscale = {
      enable = true;
      permitCertUid = "caddy";
    };

    networking.firewall.trustedInterfaces = [ "tailscaled" ];
  };
}
