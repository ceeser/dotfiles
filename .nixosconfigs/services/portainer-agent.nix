# Config for portainer agents

{ config, pkgs, ... }:

{
  imports = [];

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
}
