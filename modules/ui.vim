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
"set list
set mat=2 " how many tenths of a second to blink when matching brackets
if has('gui_running')
    set t_Co=256
    set guioptions-=T " no toolbar
    set guioptions-=m " no menu
    set guioptions-=r " no right scroll
    set guioptions-=L " no left scroll
    set guitablabel=%N/\ %t\ %M
endif

if exists('g:fvim_loaded')
    " good old 'set guifont' compatibility
    set guifont=JetBrains\ Mono:h13
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

if exists('g:fvim_loaded')
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
endif
