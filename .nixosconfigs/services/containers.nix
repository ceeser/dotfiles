# Config for neovim

{ lib, config, pkgs, ... }:

{
  options.ceeser.services.containers = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures the podman container service
      '';
    };
  };

  config = lib.mkIf config.ceeser.services.containers.enable {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    # Container policy that's reasonably locked down
    virtualisation.containers.policy = {
      default = [ { type = "reject"; } ];

      # See https://www.mankier.com/5/containers-policy.json#Examples for transport examples to selectively allow
      transports = {
        docker = { #  Allow installing images from a specific repository namespace
          "docker/dockerfile" = [ { type = "insecureAcceptAnything"; } ];
        };

        dir = {
          "" = [ {type = "insecureAcceptAnything"; } ]; # Allow any images originating in local directories
        };
      };
    };
  };
}
