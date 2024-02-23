# Convenience
abbr ~ "cd ~"
abbr .. 'cd ../'         # Go back 1 directory level
abbr ... 'cd ../../'     # Go back 2 directory levels
abbr c "clear"
abbr cp "cp -iv"         # Preferred 'cp' implementation
abbr l "eza -la --group-directories-first"
abbr ls "eza -la --group-directories-first"
abbr mv "mv -iv"         # Preferred 'mv' implementation
abbr mkdir "mkdir -pv"   # Preferred 'mkdir' implementation

# Applications
abbr cat "bat"
# abbr docker "podman"
# abbr dockerremovevolumesdangling "docker volume rm $(docker volume ls -f dangling=true -q)"
# abbr dockerpruneall "docker container prune -f && docker system prune -f && docker volume rm $(docker volume ls -f dangling=true -q)"
abbr glg "git lg"
abbr glg1 "git lg1-specific --all"
abbr glg2 "git lg2-specific --all"
abbr glg3 "git lg3-specific --all"
abbr gm "git merge"
abbr gpr "git pull --rebase"
abbr gs "git status"
abbr tmd "tmux attach -t dev || tmuxinator dev"
abbr tmk "tmux kill-session -t dev"

# Git
abbr gs "git status"
abbr gco "git checkout"

# Nix commands
abbr nec "nvim ~/.nixosconfigs/configuration.nix" # edit home config
abbr ndg "sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system" # delete specified generations
abbr ngc "sudo nix-collect-garbage --delete-old"
abbr nlg "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system" # list all generations
abbr nr "cd ~/ && sudo nixos-rebuild switch -I nixos-config=.nixosconfigs/configuration.nix" # rebuild and switch from home config
abbr nrt "cd ~/ && sudo nixos-rebuild test -I nixos-config=.nixosconfigs/configuration.nix" # rebuild and test from home config
abbr nrollb "sudo nix-env --rollback --profile /nix/var/nix/profiles/system" # rollback to previous gen
abbr nsg "sudo nix-env --switch-generation --profile /nix/var/nix/profiles/system" # switch to specified gen
abbr nsh "nix-shell --run fish" # run nix-shell with the fish shell
abbr nu "cd ~/ && sudo nixos-rebuild switch --upgrade -I nixos-config=.nixosconfigs/configuration.nix" # update to latest packages
abbr nut "cd ~/ && sudo nixos-rebuild test --upgrade -I nixos-config=.nixosconfigs/configuration.nix" # update to latest packages

# Misc
abbr delguest "sudo rm -rf /home/guest"
abbr su "su -l"
abbr sudo "sudo " # fix for recognizing aliases when sudoing
