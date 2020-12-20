if g:os == "windows"
  call plug#begin('~/AppData/Local/nvim/plugged')
else
  call plug#begin('~/.config/nvim/plugged')
endif
" file tree
Plug 'scrooloose/nerdtree'
" start screen
Plug 'mhinz/vim-startify'
" easy motion
Plug 'easymotion/vim-easymotion'
" snips
Plug 'SirVer/ultisnips'
" adaptive splits
"Plug 'camspiers/lens.vim'
" colors
Plug 'joshdick/onedark.vim'
call plug#end()
" manage plugins
nnoremap <leader>pli :PlugInstall<cr>
nnoremap <leader>plc :PlugClean<cr>
"
" nerdtree
"
noremap <c-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"
let NERDTreeWinPos='left'
let NERDTreeWinSize=30
let NERDTreeMinimalUI=1
let NERDTreeDirArrowExpandable='+'
let NERDTreeDirArrowCollapsible='-'
let NERDTreeIgnore=['__pycache__', '.idea', '.git', '.stfolder', 'a.exe']
"
" easy motion
"
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
map s <Plug>(easymotion-overwin-f)
map s <Plug>(easymotion-overwin-f2)
"
" snips
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<m-s>"
let g:UltiSnipsJumpBackwardTrigger="<m-a>"
let g:UltiSnipsEditSplit="vertical" "If you want :UltiSnipsEdit to split your window.
"
" colorscheme
"
colorscheme onedark
