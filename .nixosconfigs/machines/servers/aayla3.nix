{ lib, config, pkgs, ... }:

{
  #imports = [];
  #boot = {};

  # environment.systemPackages = with pkgs; [];

  networking.hostName = "aayla3"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services = {
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
        reverse_proxy /paperless* localhost:38454
        reverse_proxy /vaultwarden* localhost:8085
        reverse_proxy /readeck* localhost:12123
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
    paperless = {
      enable = true;
      address = "0.0.0.0";
      port = 38454;
      settings = {
        PAPERLESS_URL = "https://aayla3.bun-buri.ts.net";
        PAPERLESS_FORCE_SCRIPT_NAME = "/paperless";
        PAPERLESS_STATIC_URL = "/paperless/static/";
        PAPERLESS_OCR_USER_ARGS = {
          invalidate_digital_signatures = true;
          optimize = 1;
          pdfa_image_compression = "lossless";
        };
      };
    };
    photoprism = {
      enable = true;
      address = "0.0.0.0";
      port = 2342;
      originalsPath = "/var/lib/private/photoprism/originals";
      settings = {
        PHOTOPRISM_ADMIN_USER =  "ceeser";
        PHOTOPRISM_ADMIN_PASSWORD = "password";
        PHOTOPRISM_AUTH_MODE = "password";                    # authentication mode (public, password)
        PHOTOPRISM_BACKUP_ALBUMS = "true";
        PHOTOPRISM_BACKUP_DATABASE = "true";
        PHOTOPRISM_BACKUP_RETAIN = "3";
        PHOTOPRISM_BACKUP_SCHEDULE = "daily";
        #PHOTOPRISM_DATABASE_DRIVER = "mysql";
        #PHOTOPRISM_DATABASE_NAME = "photoprism";
        #PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
        #PHOTOPRISM_DATABASE_USER = "photoprism";
        PHOTOPRISM_DETECT_NSFW = "false";                     # automatically flags photos as private that MAY be offensive (requires TensorFlow)
        PHOTOPRISM_DISABLE_BACKUPS = "false";
        PHOTOPRISM_DISABLE_CHOWN = "true";                    # disables updating storage permissions via chmod and chown on startup
        PHOTOPRISM_DISABLE_CLASSIFICATION = "true";           # disables image classification (requires TensorFlow)
        PHOTOPRISM_DISABLE_EXIFTOOL = "true";
        PHOTOPRISM_DISABLE_FACES = "true";                    # disables face detection and recognition (requires TensorFlow)
        PHOTOPRISM_DISABLE_PLACES = "true";
        PHOTOPRISM_DISABLE_RAW = "false";                     # disables indexing and conversion of RAW images
        PHOTOPRISM_DISABLE_SETTINGS = "false";                # disables settings UI and API
        PHOTOPRISM_DISABLE_TENSORFLOW = "true";               # disables all features depending on TensorFlow
        PHOTOPRISM_DISABLE_VECTORS = "false";                 # disables vector graphics support
        PHOTOPRISM_DISABLE_WEBDAV = "false";                  # disables built-in WebDAV server
        PHOTOPRISM_EXPERIMENTAL = "false";                    # enables experimental features
        PHOTOPRISM_HTTP_CACHE_PUBLIC = "true";
        PHOTOPRISM_HTTP_COMPRESSION = "gzip";                 # improves transfer speed and bandwidth utilization (none or gzip)
        PHOTOPRISM_JPEG_QUALITY = "85";                         # a higher value increases the quality and file size of JPEG images and thumbnails (25-100)
        PHOTOPRISM_LOG_LEVEL = "error";                       # log level: trace, debug, info, warning, error, fatal, or panic
        PHOTOPRISM_ORIGINALS_LIMIT = "5000";                    # file size limit for originals in MB (increase for high-res video)
        PHOTOPRISM_RAW_PRESETS = "false";                     # enables applying user presets when converting RAW images (reduces performance)
        PHOTOPRISM_READONLY = "true";                         # do not modify originals directory (reduced functionality)
        PHOTOPRISM_SITE_CAPTION = "Photos";
        PHOTOPRISM_SITE_URL = "https://photos.ceeser.com/";   # server URL in the format "http(s)://domain.name(:port)/(path)"
        PHOTOPRISM_UPLOAD_NSFW = "true";                      # allows uploads that MAY be offensive (no effect without TensorFlow)
      };
    };
    readeck = {
      enable = true;
      settings = {
        main = {
          secret_key = "BFDE22A93F3721E80365590DD8D13562DB59D373F37A0861ED5FD3FA7D2CC540";
        };
        server = {
          host = "0.0.0.0";
          port = 12123;
          base_url = "https://aayla3.bun-buri.ts.net/readeck/";
        };
      };
    };
    restic.backups = {
      calibreweb = {
        initialize = true;
        passwordFile = "/home/ceeser/.restic/.passwords/.calibreweb";
        paths = [
          "/var/lib/calibre-web"
        ];
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
          "--keep-yearly 15"
        ];
        repository = "rest:http://aayla1.bun-buri.ts.net:8000/calibreweb";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };
      paperless = {
        initialize = true;
        passwordFile = "/home/ceeser/.restic/.passwords/.paperless";
        paths = [
          "/var/lib/paperless"
        ];
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
          "--keep-yearly 15"
        ];
        repository = "rest:http://aayla1.bun-buri.ts.net:8000/paperless";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
      };
      photoprism = {
        initialize = true;
        passwordFile = "/home/ceeser/.restic/.passwords/.photoprism";
        paths = [
          "/var/lib/private/photoprism"
        ];
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
          "--keep-yearly 15"
        ];
        repository = "rest:http://aayla1.bun-buri.ts.net:8000/photoprism";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          RandomizedDelaySec = "2h";
        };
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

  time.timeZone = "America/Toronto";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
