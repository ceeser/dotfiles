# Config for gnome desktop

{ config, pkgs, ... }:

{
  imports = [];

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
}
