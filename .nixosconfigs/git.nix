# Config for neovim

{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    config = {
      alias = {
        dotfiles = "!git --git-dir=$CEESER_DOT_FILES_PATH --work-tree=$HOME";

        lg = "!git lg1";
        lg1 = "!git lg1-specific --all";
        lg2 = "!git lg2-specific --all";
        lg3 = "!git lg3-specific --all";

        lg1-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'";
        lg2-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
        lg3-specific = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";
        checkout-branch = "!git branch --sort='-*committerdate' | fzf | xargs git checkout";
        cleanup-branch = "!git branch --sort='-*committerdate' | fzf -m | xargs git branch -d";
        uncommit = "reset HEAD^";
        mergedev = "!f() { git fetch origin dev:dev && git merge dev --no-edit; }; f";
      };

      color = {
        ui = "true";
        diff = {
          meta = "11";
          frag = "magenta bold";
          func = "146 bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
        "diff-highlight" = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };
      };

      core = {
        excludesfile = "/Users/ceeser/.gitignore_global";
        editor = "vim";
        pager = "diff-so-fancy | less --tas=2 -RFX";
      }; 

      difftool = {
        "sourcetree" = {
           cmd = "opendiff \"$LOCAL\" \"$REMOTE\""; 
           path = "";
        };
      };

      filter = {
        lfs = {
          clean = "git-lfs clean -- %f";
          smudge = "git-lfs smudge -- %f";
          process = "git-lfs filter-process";
          required = "true";
        };
      };

      init = {
        defaultBranch = "main";
      };

      interactive = {
        diffFilter = "diff-so-fancy --patch";
      };

      merge = {
        tool = "sublime";
      };

      mergetool = {
        "sourcetree" = {
           cmd = "Applications/SourceTree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\""; 
           trustExitCode = "true";
        };
        "sublime" = {
          cmd = "sublime -w $MERGED";
          trustExitCode = "false";
        };
      };

      push = {
        default = "current";
        autoSetupRemote = "true";
      };

      user = {
        email = "1509497+ceeser@users.noreply.github.com";
        name = "ceeser";
        signingkey = "B5A4627F4B252385";
      };
    }; 
  };
}
