# Config for gnome desktop

{ lib, config, pkgs, ... }:

{
  options.ceeser.desktops.gnome = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures the gnome desktop
      '';
    };
  };

  config = lib.mkIf config.ceeser.desktops.gnome.enable {
    console.useXkbConfig = true;

    environment = {
      gnome.excludePackages = with pkgs; [
        baobab # disk usage analyzer
        epiphany # web browser
        simple-scan # document scanner
        totem # video player
        yelp # help viewer
        evince # document viewer
        geary # email client
        gnome-calculator
        gnome-contacts
        gnome-logs
        gnome-maps
        gnome-music
        gnome-weather
        gnome-clocks
        gnome-text-editor
        gnome-connections
        gnome-console
        gnome-calendar
        #gnome-screenshot
        #gnome-system-monitor
      ];
    };

    programs.dconf = {
      enable = true;
      profiles.user.databases = [{
        settings = {
          "org/gnome/desktop/peripherals/mouse" = {
            natural-scroll = true;
          };
          "org/gnome/desktop/peripherals/touchpad" = {
            two-finger-scrolling-enabled = true;
          };
        };
      }];
    };

    services = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      xserver = {
        enable = true; # Enable the X11 windowing system.
        excludePackages = [ pkgs.xterm ];
        xkb = {
          options = "ctrl:nocaps"; # Remap capslock to control
          layout = "us";
        };
        # libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
      };
    };
  };
}
