# Config for neovim

{ config, pkgs, ... }:

{
  imports = [];

  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;

    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = true;

    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };
  
  # Container policy that's reasonable locked down
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

}
