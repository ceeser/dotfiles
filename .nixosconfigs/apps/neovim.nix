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
        colorscheme catppuccin-mocha

        set autoindent
        set clipboard=unnamedplus
        set completeopt=noinsert,menuone,noselect
        set cursorline
        set expandtab
        set list
        set nobackup
        set nostartofline
        set noswapfile
        set number
        set relativenumber
        set shiftwidth=2
        set smartcase
        set splitbelow splitright
        set tabstop=2
        set title
        set ttimeoutlen=0
        set wildmenu
        setlocal spell
        setlocal spelllang=en_us
        setlocal fo+=aw
        nnoremap <leader>x ZZ



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
