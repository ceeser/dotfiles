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

    # Useful other development tools
    environment.systemPackages = with pkgs; [
      devpod
      #dive # look into docker image layers
      #docker-compose # start group of containers for dev
      podman-tui # status of containers in the terminal
      #podman-compose # start group of containers for dev
    ];

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
          "nixos" = [ { type = "insecureAcceptAnything"; } ];
          "docker/dockerfile" = [ { type = "insecureAcceptAnything"; } ];
          "mcr.microsoft.com" = [ { type = "insecureAcceptAnything"; } ];
          "docker.io" = [ { type = "insecureAcceptAnything"; } ];
        };

        dir = {
          "" = [ {type = "insecureAcceptAnything"; } ]; # Allow any images originating in local directories
        };
      };
    };
  };
}
