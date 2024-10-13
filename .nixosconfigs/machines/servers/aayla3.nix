{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  #imports = [];
  #boot = {};

  environment.systemPackages = with pkgs; [] ++ baseMachineTypePackages;

  networking.hostName = "aayla3"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services = lib.recursiveUpdate baseMachineTypeServices {
    caddy = {
      enable = true;
      virtualHosts."aayla3.bun-buri.ts.net".extraConfig = ''
        handle_path /portainer/* {
          rewrite * {path}
          reverse_proxy localhost:9000
        }
        reverse_proxy /calibre* localhost:8083 {
          header_up X-Scheme https
          header_up X-Script-Name /calibre
        }
        reverse_proxy /paperless* localhost:8084
        reverse_proxy /vaultwarden* localhost:8085
      '';
    };
    calibre-web = {
      enable = true;
      listen.port = 8083;
      openFirewall = false;
      options = {
        calibreLibrary = "/var/lib/calibre-web/books";
        enableBookUploading = true;
        enableBookConversion = true;
      };
    };
    mysql = {
      enable = false;
      package = pkgs.mariadb;
      initialDatabases = [
        { name = "photoprism"; }
      ];
      ensureDatabases = [ "photoprism" ];
      ensureUsers = [
        {
          name = "photoprism";
          ensurePermissions = {
            "photoprism.*" = "ALL PRIVILEGES";
          };
        }
      ];
    };
    photoprism = {
      enable = true;
      address = "0.0.0.0";
      port = 2342;
      originalsPath = "/var/lib/private/photoprism/originals";
      settings = {
        PHOTOPRISM_AUTH_MODE = "password";                    # authentication mode (public, password)
        PHOTOPRISM_ADMIN_USER =  "ceeser";
        PHOTOPRISM_ADMIN_PASSWORD = "password";
        #PHOTOPRISM_DATABASE_DRIVER = "mysql";
        #PHOTOPRISM_DATABASE_NAME = "photoprism";
        #PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
        #PHOTOPRISM_DATABASE_USER = "photoprism";
        PHOTOPRISM_SITE_URL = "https://photos.ceeser.com/";   # server URL in the format "http(s)://domain.name(:port)/(path)"
        PHOTOPRISM_ORIGINALS_LIMIT = "5000";                    # file size limit for originals in MB (increase for high-res video)
        PHOTOPRISM_HTTP_COMPRESSION = "gzip";                 # improves transfer speed and bandwidth utilization (none or gzip)
        PHOTOPRISM_LOG_LEVEL = "error";                       # log level: trace, debug, info, warning, error, fatal, or panic
        PHOTOPRISM_READONLY = "true";                         # do not modify originals directory (reduced functionality)
        PHOTOPRISM_EXPERIMENTAL = "false";                    # enables experimental features
        PHOTOPRISM_DISABLE_CHOWN = "true";                    # disables updating storage permissions via chmod and chown on startup
        PHOTOPRISM_DISABLE_WEBDAV = "false";                  # disables built-in WebDAV server
        PHOTOPRISM_DISABLE_SETTINGS = "false";                # disables settings UI and API
        PHOTOPRISM_DISABLE_TENSORFLOW = "true";               # disables all features depending on TensorFlow
        PHOTOPRISM_DISABLE_FACES = "true";                    # disables face detection and recognition (requires TensorFlow)
        PHOTOPRISM_DISABLE_CLASSIFICATION = "true";           # disables image classification (requires TensorFlow)
        PHOTOPRISM_DISABLE_VECTORS = "false";                 # disables vector graphics support
        PHOTOPRISM_DISABLE_RAW = "false";                     # disables indexing and conversion of RAW images
        PHOTOPRISM_RAW_PRESETS = "false";                     # enables applying user presets when converting RAW images (reduces performance)
        PHOTOPRISM_JPEG_QUALITY = "85";                         # a higher value increases the quality and file size of JPEG images and thumbnails (25-100)
        PHOTOPRISM_DETECT_NSFW = "false";                     # automatically flags photos as private that MAY be offensive (requires TensorFlow)
        PHOTOPRISM_UPLOAD_NSFW = "true";                      # allows uploads that MAY be offensive (no effect without TensorFlow)
        PHOTOPRISM_SITE_CAPTION = "Photos";
        PHOTOPRISM_HTTP_CACHE_PUBLIC = "true";
      };
    };
    vaultwarden = {
      enable = true;
      dbBackend = "sqlite";
      config = {
        DOMAIN = "https://aayla3.bun-buri.ts.net/vaultwarden";
        ROCKET_ADDRESS = "0.0.0.0";
        ROCKET_PORT = "8085";
        ROCKET_LOG = "critical";
        SIGNUPS_ALLOWED = false;
      };
    };
  };

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

  time.timeZone = "America/Toronto";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
