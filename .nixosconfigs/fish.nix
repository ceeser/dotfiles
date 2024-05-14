# Config for neovim

{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # set options
      set fish_greeting

      # Env Vars
      set -gx BLOCKSIZE 1k
      set -gx COLUMNS 120
      set -gx EDITOR vim

      set -gx CEESER_DOT_FILES_REPO https://github.com/ceeser/dotfiles
      set -gx CEESER_DOT_FILES_PATH $HOME/.dotfilesrepo 
      set -gx CEESER_RESTIC_PASSWORDS_PATH $HOME/.restic/.passwords

      set -gx HOMEBREW_NO_ANALYTICS 1
      set -gx HOMEBREW_NO_INSECURE_REDIRECT 1
      set -gx HOMEBREW_CASK_OPTS --require-sha

      set -gx LANG en_US.UTF-8
      set -gx LANGUAGE en_US.UTF-8
      set -gx LC_ALL en_US.UTF-8
      set -gx LC_COLLATE C
      set -gx LC_CTYPE en_US.UTF-8

      set -gx OS $(uname)

      set -gx TERM xterm-256color

      # Init
      starship init fish | source
    '';

    shellAbbrs = {
      #~ = "cd ~"
      #.. = "cd ../"         # Go back 1 directory level
      #... = "cd ../../"     # Go back 2 directory levels
      c = "clear";
      cp = "cp -iv";        # Preferred 'cp' implementation
      l = "eza -la --group-directories-first";
      ls = "eza -la --group-directories-first";
      mv = "mv -iv";        # Preferred 'mv' implementation
      mkdir  = "mkdir -pv";  # Preferred 'mkdir' implementation

      # Applications
      cat = "bat";
      dockerremovevolumesdangling = "docker volume rm $(docker volume ls -f dangling=true -q)";
      dockerpruneall = "docker container prune -f && docker system prune -f && docker volume rm $(docker volume ls -f dangling=true -q)";
      tmd = "tmux attach -t dev || tmuxinator dev";
      tmk = "tmux kill-session -t dev";

      # Git
      gco = "git checkout";
      glg = "git lg";
      glg1 = "git lg1-specific --all";
      glg2 = "git lg2-specific --all";
      glg3 = "git lg3-specific --all";
      gm = "git merge";
      gpr = "git pull --rebase";
      gs = "git status";

      # git dotfiles
      gdtinit = "git clone --bare $CEESER_DOT_FILES_REPO $CEESER_DOT_FILES_PATH && git --git-dir=$CEESER_DOT_FILES_PATH config --local status.showUntrackedFiles no";
      gdt = "git dotfiles";

      # Nix commands
      nec = "nvim ~/.nixosconfigs/configuration.nix"; # edit home config
      ndg = "sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system"; # delete specified generations
      ngc = "sudo nix-collect-garbage --delete-old";
      nlg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system"; # list all generations
      nr = "cd ~/ && sudo nixos-rebuild switch -I nixos-config=.nixosconfigs/configuration.nix"; # rebuild and switch from home config
      nrt = "cd ~/ && sudo nixos-rebuild test -I nixos-config=.nixosconfigs/configuration.nix"; # rebuild and test from home config
      nrollb = "sudo nix-env --rollback --profile /nix/var/nix/profiles/system"; # rollback to previous gen
      nsg = "sudo nix-env --switch-generation --profile /nix/var/nix/profiles/system"; # switch to specified gen
      nsh = "nix-shell --run fish"; # run nix-shell with the fish shell
      nu = "cd ~/ && sudo nixos-rebuild switch --upgrade -I nixos-config=.nixosconfigs/configuration.nix"; # update to latest packages
      nut = "cd ~/ && sudo nixos-rebuild test --upgrade -I nixos-config=.nixosconfigs/configuration.nix"; # update to latest packages

      # Restic backups
      ## ceeser
      rc = "restic -r $HOME/data/backups/ceeser/documents -p $CEESER_RESTIC_PASSWORDS_PATH/.ceeser";
    };
  };
}
