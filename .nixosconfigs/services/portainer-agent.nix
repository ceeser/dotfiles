# Config for portainer agents

{ lib, config, pkgs, ... }:

{
  options.ceeser.services.portaineragent = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures the portainer container management agent
      '';
    };
  };

  config = lib.mkIf config.ceeser.services.portaineragent.enable {
    virtualisation.docker.enable = true;
    virtualisation.oci-containers.backend = "docker";

    virtualisation.oci-containers.containers.portainer-agent = {
      autoStart = true;
      extraOptions = [ "--privileged" ];
      image = "portainer/agent";
      ports = [
        "0.0.0.0:9001:9001"
      ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/var/run/docker/volumes:/var/run/docker/volumes"
      ];
    };

    virtualisation.oci-containers.containers.watchtower = {
      autoStart = true;
      extraOptions = [ "--privileged" ];
      image = "containrrr/watchtower";
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
    };
  };
}
