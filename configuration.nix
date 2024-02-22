# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      .nixosconfigs/desktop-env.nix
      .nixosconfigs/neovim.nix
      .nixosconfigs/no-defaults.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  documentation.nixos.enable = false;

  environment = {
    systemPackages = with pkgs; [ # List packages installed in system profile. To search, run: nix search wget
      fish
      git
      librewolf
      starship
      tailscale
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    font-awesome
  ];

  hardware.pulseaudio.enable = false; # Enable sound with pipewire.

  i18n.defaultLocale = "en_CA.UTF-8"; # Select internationalisation properties.

  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscaled" ];
    };
    networkmanager.enable = true; # Enable networking
    hostName = "tera"; # Define your hostname.

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy = {
      # default = "http://user:password@proxy:port/";
      # noProxy = "127.0.0.1,localhost,internal.domain";
    # };

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
  };

  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  nix = {
    settings.allowed-users = [ "@wheel" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    fish.enable = true;
    virt-manager.enable = true;
  };

  security = {
    rtkit.enable = true;
    sudo.execWheelOnly = true;
  };

  services = {
    openssh.enable = false; # Enable the OpenSSH daemon.

    # Enable CUPS to print documents.
    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # List services that you want to enable:
    flatpak.enable = true;
    tailscale.enable = true;
  };

  sound.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.fish;
    users = {
      guest = {
        description = "guest";
        hashedPassword = "$6$rounds=1000$jpMpD5UmWhlVZyXN$wKOvA4n/6nTQpAxoA3SctqpcsmJ5eQuI0CgOPK3/83Tx27ZM9d4mrKZgoCctXTB5wixLaiv8XQUg0XfNw9Haj1";
        isNormalUser = true;
        shell = "/run/current-system/sw/bin/bash --restricted";
        useDefaultShell = false;
      };
      crywolf = {
        description = "crywolf";
        extraGroups = [ "networkmanager" "wheel" ];
        isNormalUser = true;
        packages = with pkgs; [
          alacritty
          bat
          diff-so-fancy
          du-dust
          element-desktop
          eza
          firefox
          gimp
          libreoffice
          localsend
          pandoc
          thunderbird
          tmux
          tmuxinator
          tor-browser
          vlc
          vscodium
        ];
      };
    };
  };

  virtualisation = {
    libvirtd.enable = true;
    podman.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
