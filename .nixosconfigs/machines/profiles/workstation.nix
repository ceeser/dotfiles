{ lib, config, pkgs, ... }:

{
  options.ceeser.machines.workstation = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Determines whether a machine is a workstation and installs / activates a desktop with apps
      '';
    };
  };

  config = lib.mkIf config.ceeser.machines.workstation.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;

    ceeser.desktops.cosmic.enable = true;
    ceeser.programs.lazygit.enable = true;
    ceeser.programs.chromium.enable = true;
    ceeser.programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
      ## development
      diff-so-fancy
      zed-editor
        ### rust
        cargo
        clippy
        rust-analyzer
        rustc
        rustfmt

      ## general apps
      aerc
      bitwarden-desktop
      evince
      gnome-system-monitor
      pandoc
      rates
      tor-browser
      ungoogled-chromium
      vlc
      zellij
      qalculate-gtk

      ## tools
      zenith
      bluetui
    ];

    hardware.bluetooth.settings = {
      General = {
        ControllerMode = "bredr";
      };
      Policy = {
        AutoEnable = "true";
      };
    };

    programs.localsend.enable = true;

    security.rtkit.enable = true; # added for pipewire
    services = {
      flatpak.enable = true;
      fwupd.enable = true;

      openssh.enable = false;

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
      };

      printing.enable = false; # Enable CUPS to print documents
      pulseaudio.enable = false;

      syncthing.settings = {
        devices = {
          "darnala" = {
            id = "DVPFUWJ-CATWISM-VWPQTXI-7Z64GED-JCLBWYJ-NTXLAOB-LVLHFET-V3T64AN";
            addresses = [
              "tcp://darnala.bun-buri.ts.net"
            ];
          };
          "tera" = {
            id = "PWUB6TF-22JA5L5-TQIEUWT-6PFBSWW-XWLJ5EX-GZXMRNT-MEBYRS3-BLBWTA5";
            addresses = [
              "tcp://tera.bun-buri.ts.net"
            ];

          };
        };
        folders = {
          "Downloads" = {
            path = "/home/ceeser/Downloads";
            devices = [ "darnala" "tera" ];
          };
        };
      };
    };

    users.users = {
      guest = {
        description = "guest";
        hashedPassword = "$6$rounds=1000$jpMpD5UmWhlVZyXN$wKOvA4n/6nTQpAxoA3SctqpcsmJ5eQuI0CgOPK3/83Tx27ZM9d4mrKZgoCctXTB5wixLaiv8XQUg0XfNw9Haj1";
        isNormalUser = true;
        shell = "/run/current-system/sw/bin/bash --restricted";
        useDefaultShell = false;
      };
      ceeser = {
        description = "ceeser";
        extraGroups = [ "networkmanager" "podman" "wheel" ];
        isNormalUser = true;
      };
    };
  };
}
