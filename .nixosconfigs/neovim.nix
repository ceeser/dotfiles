# Config for neovim

{ config, pkgs, ... }:

{
  imports = [];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        colorscheme catppuccin
        set clipboard=unnamedplus
        set completeopt=noinsert,menuone,noselect
        set cursorline
        set expandtab
        set list
        set number
        set relativenumber
        set shiftwidth=2
        set splitbelow splitright
        set tabstop=2
        set title
        set ttimeoutlen=0
        set wildmenu
        lua require 'ibl'.setup()
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          catppuccin-nvim
          indent-blankline-nvim
        ];
      };
    };
  };
}
