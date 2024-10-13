# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, basePackages, baseServices, parameters, ... }:

let
  baseMachineTypePackages = with pkgs; [
    diff-so-fancy
  ] ++ basePackages;

  baseMachineTypeServices = lib.recursiveUpdate baseServices {
    openssh = {
      enable = true;
      # require public key authentication for better security
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      settings.PermitRootLogin = "no";
    };
  }; 

in {
  imports = [
    (../services/pull-dotfiles-repo.nix)

    # Machine specific config
    (
      import (./servers + "/${parameters.machine}.nix") {
        inherit lib;
        inherit config;
        inherit pkgs;
        inherit baseMachineTypePackages;
        inherit baseMachineTypeServices;
        # inherit parameters;
      }
    )
  ];

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1; # ipv4 forwarding
  boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = 1; #ipv6 forwarding

  environment.defaultPackages = [];

  system.autoUpgrade = {
    allowReboot = true;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "Sat *-*-* 03:00:00"; # every saturday at 3 am
    enable = true;
    flags = [
      "-I"
      "nixos-config=/home/ceeser/.nixosconfigs/configuration.nix"
    ];
    randomizedDelaySec = "45min";
  };

  users.users = {
    ceeser = {
      extraGroups = [ "networkmanager" "wheel" ];
      initialHashedPassword = "$y$j9T$XaUpu.uuIDnfAYfzPxKqW.$LF6faepJC1x3F2akjhbv0fUkl314I7E3XmVekKL7TBA";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBADbQB9eZMIYo0l+CGxMnqNuWjCVqUhEKFOpWpJG0OqNkiqvozTcSYOu8MggCjDOFRzxn4rnN3Tyzb/gtXZREBTCFAF8ZBymZ4ZJYfFZn0C5vqI2szGrHRbhcu/YMo6aJwxbkQFZ2leXkyCKYCXuFYTtNCu1MxBw3iDn2MlGjK2FH0m3dA== ceeser"
      ];
    }; 
  };

  xdg.icons.enable  = false;
  xdg.mime.enable   = false;
  xdg.sounds.enable = false;
}
