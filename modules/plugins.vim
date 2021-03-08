if g:os == "windows"
  call plug#begin('~/AppData/Local/nvim/plugged')
else
  call plug#begin('~/.config/nvim/plugged')
endif

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

"noremap <c-n> :NERDTreeToggle<CR>
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

let g:coc_global_extensions = ['coc-python', 'coc-omnisharp']
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>af  <Plug>(coc-fix-current)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'ada0l/sunpurple'

call plug#end()

colorscheme sunpurple
