"
"   _____       .___             .__
"  /  _  \    __| _/____    ____ |  |
" /  /_\  \  / __ |\__  \  /  _ \|  |
"/    |    \/ /_/ | / __ \(  <_> )  |__
"\____|__  /\____ |(____  /\____/|____/
"        \/      \/     \/
"
" github: https://github.com/ada0l
"
if has("win64") || has("win32") || has("win16")
    let g:os = "windows"
    set shell=cmd
    set shellquote= shellpipe=\| shellxquote=
    set shellcmdflag=\ -NoLogo\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
    let g:python3_host_prog='C:\\Python39\\python.EXE'
else
    let g:os = "unix"
endif
function! Dot(path)
    if g:os == "windows"
        return '~/AppData/Local/nvim/' . a:path
    return '~/.config/nvim/' . a:path
endfunction
function! LoadDotFileIfExist(file)
    if !empty(glob(Dot(a:file)))
        execute 'source ' . Dot(a:file)
    endif
endfunction
let g:init_file = Dot('init.vim') " vimrc
set history=500 " sets how many lines of history
filetype plugin on " enable filetype
filetype indent on
set ffs=unix,dos,mac " use Unix as the standard file type
set nobackup " turn backup off
set nowb
set noswapfile
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set list
set hlsearch " search hl
set incsearch
set ignorecase
set smartcase
set clipboard=unnamedplus " use system clipboard
set autoread " auto load when a file is changed
au FocusGained,BufEnter * checktime
autocmd BufWritePre * " automatically creating directory
    \ if !isdirectory(expand("<afile>:p:h")) |
    \   call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
set number " numbers
set showmatch " show match of brackets and etc.
set foldenable  " enable folding
set foldcolumn=2 " add a fold column
set foldmethod=marker " detect triple-{ style fold markers
set foldlevelstart=99 " start out with everything unfolded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
"
" Mapping
"
let mapleader = ","
" fast save exit
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>Q :qall<cr>
" exit insert mode
imap jj <Esc>
" load/open vimrc
command! SourceVimrc execute 'source ' . g:init_file
command! OpenVimrc execute 'e ' . g:init_file
nmap <leader>vo :OpenVimrc<cr>
nmap <leader>vs :SourceVimrc<cr>
" switch CWD
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr><cr>
" copy/paste
nmap <leader>p "*p
nmap <leader>y "*y
" TODO
"nnoremap <leader>P A<space><c-r>"<esc>
" redo
nmap <leader>r <c-r>
" remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk
" copy whole file
noremap <leader>cw :%y+<cr>
" search
nmap <leader><cr> :noh<cr>
nmap <space> /
nmap <c-space> ?
" moving between windows
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key, '[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>
" Maps Alt-[h,j,k,l] to resizing a window split
map <silent> <A-h> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-l> <C-w>>
nnoremap <leader>bb :buffers<cr>:b<space>
" exit from term mode
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>t :wincmd v<cr>:wincmd l<cr>:term<cr>i
" avoid Ex mode
noremap Q <nop>
"
" Tab and indent
"
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set lbr
set tw=500
set ai " auto indent
set si " smart indent
set wrap " wrap line
"
" User Interface
"
syntax on
set fillchars+=vert:│
set so=7
set textwidth=80 " show line breaker
set colorcolumn=+1
set cursorline
set mat=2 " how many tenths of a second to blink when matching brackets
if has('gui_running')
    set t_Co=256
    set guioptions-=T " no toolbar
    set guioptions-=m " no menu
    set guioptions-=r " no right scroll
    set guioptions-=L " no left scroll
    set guitablabel=%N/\ %t\ %M
endif
"
" Extentins
"
call LoadDotFileIfExist('local.vim')
call LoadDotFileIfExist('plugins.vim')
