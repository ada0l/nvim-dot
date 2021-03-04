let g:init_file = Dot('init.vim') " vimrc
set history=500 " sets how many lines of history
set ffs=unix,dos,mac " use Unix as the standard file type
set nobackup " turn backup off
set noswapfile

"search
set hlsearch
set incsearch

set autoread " auto load when a file is changed
au CursorHold * checktime

" automatically creating directory
autocmd BufWritePre *
    \ if !isdirectory(expand('<afile>:p:h')) |
    \   call mkdir(expand('<afile>:p:h'), 'p') |

set expandtab smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set lazyredraw
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4

nnoremap <C-n> :Vexplore!<CR>
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_browse_split = 3
let g:netrw_banner = 0
let g:netrw_liststyle = 3

