let mapleader = " "

nmap <leader>vo :OpenVimrc<cr>
nmap <leader>vs :SourceVimrc<cr>

nmap <leader>w :w<cr>
nmap <leader>q :q<cr>

imap jj <esc>

nmap <leader>l :set list!<cr>

" copy/paste from system clipboard
nmap <leader>p "+p
nmap <leader>y "+y

vnoremap > >gV
vnoremap < <gV

nnoremap <m-u> <C-U>
nnoremap <M-d> <C-D>

nnoremap <C-U> <Nop>
nnoremap <C-D> <Nop>

nmap <leader><cr> :noh<cr>

" switch CWD
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr><cr>
map <leader>e :Ex<cr>

" buffers
nmap <tab> :bnext<cr>
nmap <s-tab> :bprev<cr>
nmap <leader>bb :buffers<cr>:b<space>
nmap <leader>bd :bd<cr>

" movement in insert mode
imap <M-h> <C-o>h
imap <M-j> <C-o>j
imap <M-k> <C-o>k
imap <M-l> <C-o>l

" cool stuff
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

map <silent> <M-h> :call WinMove('h')<CR>
map <silent> <M-j> :call WinMove('j')<CR>
map <silent> <M-k> :call WinMove('k')<CR>
map <silent> <M-l> :call WinMove('l')<CR>
map <silent> <M-L> :vertical resize +5<CR>
map <silent> <M-H> :vertical resize -5<CR>
map <silent> <M-K> :res +5<cr>
map <silent> <M-J> :res -5<cr>

" exit from term mode
tnoremap <Esc> <C-\><C-n>

" avoid Ex mode
noremap Q <nop>
