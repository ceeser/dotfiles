# Config for neovim

{ config, pkgs, ... }:

{
  programs.tmux = {
    clock24 = true;
    enable = true;

    extraConfig = ''
      # Set the prefix from Ctrl-b to Ctrl-a
      set -g prefix C-a

      # Free the original Ctrl-b binding
      unbind C-b

      # Set delay between prefix and command
      set -s escape-time 1

      # Set the base index for windows to 1 instead of 0
      set -g base-index 1

      # Set the base index for panes to 1 instead of 0
      setw -g pane-base-index 1

      # Set scrollback buffer default
      set -g history-limit 10240

      # Set focus events on
      set -g focus-events on

      # Reload tmux config file
      bind r source-file /etc/tmux.conf \; display "Reloaded!"

      # Ensure we can send prefix key to other apps
      bind C-b send-prefix

      # Splitting panes with | and -
      bind | split-window -h
      bind - split-window -v

      # Moving between panes with Prefix h,j,k,l
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Quick window selection
      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+

      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Synchronize panes
      bind C-x setw synchronize-panes

      # Mouse support - set to on to use
      set -g mouse off

      # Set the default terminal mode to 256color mode
      set -g default-terminal "xterm-256color"

      # Colors
      fg='#CBCCC6'
      bg='#212732'
      status_bg='#34455A'
      border_fg='#70748C'
      border_active_fg='#FECB6E'
      status_left_bg='#FFA759'
      status_left_fg='#212732'

      # Border
      set -g pane-border-style 'fg=$border_fg'
      set -g pane-active-border-style 'fg=$border_active_fg'

      # Window
      set -g window-status-current-style 'fg=$border_active_fg'
      set -g window-status-style 'fg=$fg'

      # Command / message line
      set -g message-style fg=$fg,bold,bg=$bg

      # Enable activity alerts
      setw -g monitor-activity on
      set -g visual-activity on

      # enable vi keys
      set -g mode-keys vi

      # Status Bar
      set -g status 'on'
      set -g status-utf8 'on'
      set -g status-interval 10
      set -g status-justify 'centre'
      set -g status-bg 'colour235'
      set -g message-command-fg 'colour222'
      set -g status-left-length '100'
      #set -g pane-active-border-fg 'colour154'
      set -g message-bg 'colour238'
      set -g status-right-length '100'
      set -g status-right-attr 'none'
      set -g message-fg 'colour222'
      set -g message-command-bg 'colour238'
      set -g status-attr 'none'
      #set -g pane-border-fg 'colour238'
      set -g status-left-attr 'none'
      setw -g window-status-fg 'colour121'
      setw -g window-status-attr 'none'
      setw -g window-status-activity-bg 'colour235'
      setw -g window-status-activity-attr 'none'
      setw -g window-status-activity-fg 'colour154'
      setw -g window-status-separator ""
      setw -g window-status-bg 'colour235'

      set -g status-left '#[fg=colour232,bg=colour154] #S #[fg=colour154,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour222,bg=colour238] #W #[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour121,bg=colour235] #(whoami)  #(uptime  | cut -d " " -f 1,2,3) #[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]'

      set -g status-right '#[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour121,bg=colour235] %r  %a  %Y #[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]#[fg=colour222,bg=colour238] #H #[fg=colour154,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour232,bg=colour154] #(rainbarf --battery --remaining --no-rgb) '

      setw -g window-status-format '#[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]#[default] #I  #W #[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]'

      setw -g window-status-current-format '#[fg=colour235,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour222,bg=colour238] #I  #W  #F #[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]'

      # Status Bar
      #set -g status-style 'bg=$status_bg,fg=$fg'
      #set -g status-left-style 'bg=$status_left_bg,fg=$status_left_fg'
      #set -g status-right-style 'bg=$status_bg,fg=$fg'

      # Status line left side to show Session:window:pane
      #set -g status-left-length 80
      #set -g status-left '#H session: #S #I:#P'

      # Status line right side - 31-Oct 13:37
      #set -g status-right-length 60
      #set -g status-right '#(TZ=UTC date -u +%%d\\ %%b\\ %%R) UTC | #(/bin/bash $HOME/Documents/source/thirdparty/kube-tmux/kube.tmux 250 red cyan)'

      # Update the status line every sixty seconds
      #set -g status-interval 10

      # Center the window list in the status line
      #set -g status-justify centre
    '';
  };
}
