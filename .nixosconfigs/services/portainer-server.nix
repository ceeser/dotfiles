# Config for portainer server

{ config, pkgs, ... }:

{
  imports = [];

  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  virtualisation.oci-containers.containers.portainer = {
    autoStart = true;
    cmd = [ "--base-url=/portainer" ];
    extraOptions = [
      "--privileged"
    ];
    image = "portainer/portainer-ce";
    ports = [
      "8000:8000"
      "9000:9000"
      "9443:9443"
    ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "portainer_data:/data"
    ];
  };
}
