# Imports
source $HOME/.config/fish/conf.d/abbr.fish

# set options
set fish_greeting

# Env Vars
set -gx EDITOR vim
set -gx OS $(uname)

set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx LC_COLLATE C
set -gx LC_CTYPE en_US.UTF-8

set -gx HOMEBREW_NO_ANALYTICS 1
set -gx HOMEBREW_NO_INSECURE_REDIRECT 1
set -gx HOMEBREW_CASK_OPTS --require-sha

set -gx BLOCKSIZE 1k
set -gx TERM xterm-256color
set -gx COLUMNS 120

# Init
starship init fish | source
