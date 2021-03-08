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

nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
