{ lib, config, pkgs, ... }:

{
  ceeser.machines.server.enable = true;

  environment.systemPackages = with pkgs; [
    ## development
    lazygit

      ### rust
      cargo
      cargo-audit
      cargo-expand
      cargo-tarpaulin
      cargo-watch
      clippy
      gcc
      openssl
      pkg-config
      rust-analyzer
      rustc
      rustfmt

    ## general apps
    zellij

    ## tools
    zenith
  ];
  networking.hostName = "aayla2"; # Define your hostname.

  system.autoUpgrade.allowReboot = lib.mkForce false; # disable auto reboot to prevent interrupting processes

  time.timeZone = "America/Toronto";

  users.users.agentsmith = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBADbQB9eZMIYo0l+CGxMnqNuWjCVqUhEKFOpWpJG0OqNkiqvozTcSYOu8MggCjDOFRzxn4rnN3Tyzb/gtXZREBTCFAF8ZBymZ4ZJYfFZn0C5vqI2szGrHRbhcu/YMo6aJwxbkQFZ2leXkyCKYCXuFYTtNCu1MxBw3iDn2MlGjK2FH0m3dA== ceeser"
    ];
    packages = with pkgs; [
      claude-code
      claude-monitor
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
