"
" Loading
"
    if has("win64") || has("win32") || has("win16")
        let g:os = "windows"
        "set shell=cmd
        "set shellquote= shellpipe=\| shellxquote=
        "set shellcmdflag=\ -NoLogo\ -ExecutionPolicy\ RemoteSigned\ -Command
        "set shellredir=\|\ Out-File\ -Encoding\ UTF8
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
    command! SourceVimrc execute 'source ' . g:init_file
    command! OpenVimrc execute 'e ' . g:init_file
"
" GENERAL
"
    let g:init_file = Dot('init.vim') " vimrc
    set history=500 " sets how many lines of history
    set ffs=unix,dos,mac " use Unix as the standard file type
    set nobackup " turn backup off
    set noswapfile

    "search
    set hlsearch
    set incsearch

    set autoread " auto load when a file is changed
    au FileChangedShell,FocusGained,BufEnter * checktime
    au CursorHold * checktime

    " automatically creating directory
    "autocmd BufWritePre *
        "\ if !isdirectory(expand('<afile>:p:h')) |
        "\   call mkdir(expand('<afile>:p:h'), 'p') |
"
" TABS
"
    set expandtab smarttab
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set autoindent
    set smartindent
    set lazyredraw
    autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
"
" MAPPING
"
    let mapleader = " "

    nmap <leader>vo :OpenVimrc<cr>
    nmap <leader>vs :SourceVimrc<cr>

    nmap <leader>w :w<cr>
    nmap <leader>q :q<cr>

    imap jj <esc>

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

    " exit from term mode
    tnoremap <Esc> <C-\><C-n>

    " avoid Ex mode
    noremap Q <nop>
"
" UI
"
    syntax on
    set number
    "set fillchars+=vert:│
    set so=7
    set textwidth=80 " show line breaker
    set colorcolumn=+1
    set cursorline
    " Display extra whitespace
    set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:·
    set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
    set list
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
" STATUSLINE
"
    function! StatusLineRenderer()
        let mode_colors = {
              \ 'n':  'DiffAdd',
              \ 'v':  'DiffDelete',
              \ '^V': 'DiffDelete',
              \ 'i':  'DiffChange',
              \ 'c':  'DiffChange',
              \ 'r':  'DiffChange'
              \ }
      let hl = '%#' . get(mode_colors, tolower(mode()), mode_colors.n) . '#'
      let clear = "%#Visual#"
      return
            \ hl
            \ . " "
            \ . (mode() == 'n' ? "NORMAL" : "")
            \ . (mode() == 'i' ? "INSERT" : "")
            \ . (mode() == 'R' ? "REPLACE" : "")
            \ . (mode() == 'v' ? "VISUAL" : "")
            \ . (mode() == 'V' ? "VISUAL LINE" : "")
            \ . (mode() == 'c' ? "COMMAND" : "")
            \ . " "
            \ . clear
            \ . (&modified ? ' + │' : '')
            \ . " %{StatusLineFilename()}"
            \ . clear
            \ . "%="
            \ . (&ft == 'markdown' ? "%{WordCount()}," : "")
            \ . "\ %Y "
            \ . hl
            \ . ' %l:%c '
    endfun

    function! StatusLineFilename()
      if (&ft ==? 'netrw') | return '*' | endif
      return substitute(expand('%'), '^' . getcwd() . '/\?', '', 'i')
    endfun

    function! WordCount()
      let s:old_status = v:statusmsg
      exe "silent normal g\<c-g>"
      let s:word_count = str2nr(split(v:statusmsg)[11])
      let v:statusmsg = s:old_status
      return s:word_count
    endfunction

    " only set default statusline once on initial startup.
    " ignored on subsequent 'so $MYVIMRC' calls to prevent
    " active buffer statusline from being 'blurred'.
    if has('vim_starting')
      let clear = "%#Visual#"
      let &statusline = clear . ' %{StatusLineFilename()}%= %l:%c '
    endif

    augroup vimrc
      au!
      " show focussed buffer statusline
      au FocusGained,VimEnter,WinEnter,BufWinEnter *
        \ setlocal statusline=%!StatusLineRenderer()
      " show blurred buffer statusline
      au FocusLost,VimLeave,WinLeave,BufWinLeave *
        \ setlocal statusline&
    augroup END
"
" TAB
"
    function! MyTabLabel(n)
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
        return empty(string) ? '[unnamed]' : string
    endfunction

    function! MyTabLine()
        let s = ''
        for i in range(tabpagenr('$'))
        " select the highlighting
            if i + 1 == tabpagenr()
                let s .= '%#DiffAdd#'
            else
                let s .= '%#DiffChange#'
            endif
            let s .= ' '. (i+1) . ' '
            " the label is made by MyTabLabel()
            let s .= '%#Cursor  #%{MyTabLabel(' . (i + 1) . ')} '
            if i+1 < tabpagenr('$')
                let s .= ' '
            endif
        endfor
        let s.= '%#CursorLine#'
        return s
    endfunction
    set tabline=%!MyTabLine()
"
" Plugins
"
    if g:os == "windows"
      call plug#begin('~/AppData/Local/nvim/plugged')
    else
      call plug#begin('~/.config/nvim/plugged')
    endif

    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
        noremap <c-n> :NERDTreeToggle<CR>
        let NERDTreeShowHidden=1
        let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
        let NERDTreeWinPos='left'
        let NERDTreeWinSize=30
        let NERDTreeMinimalUI=1
        let NERDTreeDirArrowExpandable='+'
        let NERDTreeDirArrowCollapsible='-'
        let NERDTreeIgnore=['__pycache__', '.idea', '.git', '.stfolder', 'a.exe']

    Plug 'easymotion/vim-easymotion'
        let g:EasyMotion_do_mapping = 0
        let g:EasyMotion_smartcase = 1
        map s <Plug>(easymotion-overwin-f)
        map s <Plug>(easymotion-overwin-f2)

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
        nnoremap <leader>f :FZF<cr>

    Plug 'SirVer/ultisnips'
        let g:UltiSnipsExpandTrigger="<m-d>"
        let g:UltiSnipsJumpForwardTrigger="<m-s>"
        let g:UltiSnipsJumpBackwardTrigger="<m-a>"
        let g:UltiSnipsEditSplit="vertical"

    Plug 'justinmk/vim-syntax-extra'

    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
        "let g:coc_global_extensions = [ 'coc-ccls' ]
        " Remap keys for applying codeAction to the current line.
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Apply AutoFix to problem on the current line.
        nmap <leader>af  <Plug>(coc-fix-current)
        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

    Plug 'plasticboy/vim-markdown'
    Plug 'flazz/vim-colorschemes'
    Plug 'yassinebridi/vim-purpura'
    Plug 'wadackel/vim-dogrun'
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'junegunn/goyo.vim'
    Plug 'nightsense/strawberry'
    call plug#end()

    "colorscheme hybrid
    colorscheme dogrun
"
" LOAD OTHER STUFF
"
call LoadDotFileIfExist('local.vim')
call LoadDotFileIfExist('colors.vim')
