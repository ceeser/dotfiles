# Config for neovim

{ config, pkgs, ... }:

{
  imports = [];

  console.useXkbConfig = true; # Enable the GNOME Desktop Environment.

  environment = {
    gnome.excludePackages = with pkgs.gnome; [
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
      pkgs.gnome-text-editor
      pkgs.gnome-connections
      pkgs.gnome-console
      gnome-calendar
      #gnome-screenshot
      #gnome-system-monitor
    ];
  };

  services = {
    xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      enable = true; # Enable the X11 windowing system.
      excludePackages = [ pkgs.xterm ];
      layout = "us";
      xkbOptions = "ctrl:nocaps"; # Remap capslock to control
      xkbVariant = "";
      # libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
    };
  };
}
