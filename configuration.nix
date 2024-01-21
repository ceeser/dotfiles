# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tera"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkbOptions = "ctrl:nocaps";
  console.useXkbConfig = true;
  environment.gnome.excludePackages = with pkgs.gnome; [
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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.crywolf = {
    isNormalUser = true;
    description = "crywolf";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      librewolf
      thunderbird
      vscodium
    ];
  };

  users.defaultUserShell = pkgs.zsh;

  environment.shellAliases = {
    # Convenience
    c = "clear";
    l = "ls -lah";
    vi = "spacevim";
    vim = "spacevim";

    # Dotfiles Config
    config = "/run/current-system/sw/bin/git --git-dir=$HOME/.myconfig/ --work-tree=$HOME";

    # Git
    gs = "git status";

    # Nix commands
    nec = "sudo spacevim /etc/nixos/configuration.nix";
    ndg = "sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system";
    ngc = "sudo nix-collect-garbage --delete-old";
    nlg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    nr = "sudo nixos-rebuild switch";
    nu = "sudo nixos-rebuild switch --upgrade";

    # Misc
    sudo = "sudo "; # fix for recognizing aliases when sudoing
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    bat
    diff-so-fancy
    git
    spacevim
    tailscale
    tmux
    tmuxinator
    zathura
    zsh
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.zsh.enable = true;

  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "vscode" "docker" ];
    theme = "robbyrussell";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  virtualisation.podman.enable = true;


  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    font-awesome_5
  ];

  # List services that you want to enable:

   services.tailscale.enable = true;
   services.flatpak.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
