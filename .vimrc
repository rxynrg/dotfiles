set autochdir               " Change CWD when one have opened a file
set autoindent              " Copy indent from current line when starting a new line
set autowrite               " Automatically save before :next, :make etc.
set clipboard=unnamedplus   " Copy & paste to the system clipboard
set encoding=utf-8
set expandtab               " Expand tabs into spaces
set fencs=utf-8
set fileformat=unix
set history=100
set hlsearch
set ignorecase              " Search case insensitively
set incsearch
set laststatus=1            " Show status line if 2+ windows
set noswapfile              " Do not use swapfile
set number                  " Show line numbers
set relativenumber
set scrolloff=999
set shiftwidth=2            " Number of spaces to use for each step of indent
set showcmd                 " Show last command
set showmatch               " Highlight matching parenthesis
set smartindent
set smarttab
set softtabstop=2
set splitbelow              " Split windows below to the current window
set splitright              " Split windows right to the current window
set tabstop=2               " Number of spaces a TAB counts for
set termguicolors           " Enable 24-bit RGB colors
set ttyfast
set viminfofile=NONE        " Completely disable .viminfo logging
set wildmenu
set wrap

autocmd FileType make setlocal noexpandtab

" colorscheme habamax
" colorscheme quiet
syntax on
