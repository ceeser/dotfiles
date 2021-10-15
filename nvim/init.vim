""""""""""""" Autoload Section
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif



""""""""""""" Plugin Section
call plug#begin("~/.vim/plugged")

  " Visual
  Plug 'Luxed/ayu-vim'

  " Editor
  Plug 'ryanoasis/vim-devicons'
  Plug 'airblade/vim-gitgutter'
  Plug 'preservim/nerdtree'
  Plug 'kyazdani42/nvim-web-devicons'

  " Fuzzy finder
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

call plug#end()



""""""""""""" Config Section
set nocompatible
set backspace=indent,eol,start    " osx backspace fix
set modelines=0                   " dont need modelines and the potential security hazard
set ruler                         " ruler on
set nu                            " line numbers on
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp   " store swap files here
set scrolloff=2
set shortmess=atI
set visualbell                    " don't beep
set noerrorbells                  " don't beep
set autoread                      " auto read when a file is changed on disk
set laststatus=2                  " always show status line

"  colors
if (has("termguicolors"))
 set termguicolors
endif


" scheme
colorscheme ayu
set background=dark
let g:ayucolor="dark"


" show trailing whitespace chars
set list
set listchars=tab:>-,trail:.,extends:#,nbsp:.


" buffer management and history
set hidden              " hide buffers instead of closing them
set history=100
set undolevels=100


" tab -> spaces
set expandtab
set tabstop=2           " a tab is 2 spaces
set softtabstop=2       " tab size when insterting/pasting
set shiftwidth=2        " number of spaces to use for autoindenting
set shiftround 	        " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab            " insert tabs on the start of a line according to shiftwidth, not tabstop


" indenting
set autoindent          " always set autoindenting on
set copyindent          " copy the previous indentation on autoindenting


" code folding
set nofoldenable
set foldmethod=indent   " fold based on indentation
set foldnestmax=10
set foldlevel=1



" syntax
syntax enable
filetype on             " enable syntax highlighting
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins


" search settings
set incsearch           " show search matches as you type
set ignorecase          " case insensitive search
set smartcase           " if a capital letter is included in search, make it case-sensitive
set nohlsearch          " dont highlight search results



" key remappings

" make j and k act normally for wrapped lines
nnoremap j gj
nnoremap k gk

" make regexp search not suck by default -
"nnoremap / /v
"vnoremap / /v

" easier window switching
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

map <Tab><Tab> <C-W>w

nnoremap <F2><F2> :vsplit<CR>                     " verticle split current window
nnoremap <F4><F4> :set invwrap wrap?<CR>          " use f4f4 to toggle wordwrap
nnoremap <F5><F5> :set invhls hls?<CR>            " use f5f5 to toggle search hilight
map <F7> :b#<CR>

cmap w!! w !sudo tee % >/dev/null                 " allow saving a sudo file if forgot to open as sudo

nmap <leader>o :set paste!<CR>                    " remove trailing whitespace
map <leader>d :NERDTreeToggle<CR>                 " toggle NERDTree drawer

nnoremap <C-p> :Telescope find_files<CR>
map <leader>g :Telescope git_files<CR>

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>  " remove trailing whitespace




" Auto Commands Section
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''

" Turn on spell check for certain filetypes automatically
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us

" Autowrap text to 80 chars for certain filetypes
"autocmd BufRead,BufNewFile *.md setlocal textwidth=80
"autocmd BufRead,BufNewFile *.txt setlocal textwidth=80
"autocmd FileType gitcommit setlocal textwidth=80

