set nocompatible
" treat header files as c++ files for syntax highlighting
autocmd BufEnter *.hpp,*.h :setlocal filetype=cpp
" default <Leader> is backslash(\), but changing it to ',' would be more convenient
let mapleader = ","
"""""""""""""""""""""""""""""""""""""
" PLUGIN
""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim " set runtime path
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " required

Plugin 'scrooloose/nerdtree'
Plugin 'ericcurtin/CurtineIncSw.vim'
Plugin 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/syntastic'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on
"""""""""""""""""""""""""""""""""""""""
" PlUGIN SETTING
"""""""""""""""""""""""""""""""""""""""
"" NERDTree
" open NERdTree automatically when vim starts up
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p
" open NERDTree automatically when vim starts up if no files were specified 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1&& isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close vim if the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" toggle NERDTree with \nt
nmap <F6> :NERDTreeToggle<CR>
" general config
let g:NERDTreeMouseMode=3 " single click to open directories/files
let NERDTreeWinSize=27
let NERDTreeWinPos="left"
""""""""""""""""""""""""""""""""""""""""
"" CurtineIncSw.vim
map <F5> :call CurtineIncSw()<CR> " press F5 to toggle between xyz.cpp & xyz.h
""""""""""""""""""""""""""""""""""""""""
"" coc.vim
call coc#util#install() " remember to clone the coc.vim repo under plugin/ first, this line will prevent the JAVASCRIPT FILE NOT FOUND err
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
		inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use ? to show documentation in preview window.
nnoremap <silent> D :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"""""""""""""""""""""""""""""""""""""""
"" tagbar
" autocmd FileType c,cpp nested :TagbarOpen " open tagbar only for specific filetypes
nmap <F8> :TagbarToggle<CR>
"""""""""""""""""""""""""""""""""""""""
"" ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" when the project is too big, ctrlp fails finding all documents
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=100
" set this to 1 to set searching by filename (as opposed to full path) as the default
let g:ctrlp_by_filename=1
" when opening a file, if it's already open in a window somewhere, CtrlP will try to jump to it instead of opening a new instance
let g:ctrlp_switch_buffer='Et'
" CtrlP uses grep as default seraching tool, we can change it to ag for better performance
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " Ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
"""""""""""""""""""""""""""""""""""""""
"" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"""""""""""""""""""""""""""""""""""""""
"" syntastic
"""""""""""""""""""""""""""""""""""""""
"" ack
" not to jump to the first result automatically
"cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
let g:ackprg = 'ag --nogroup --nocolor --column'
"""""""""""""""""""""""""""""""""""""""
" COLORS AND FONTS
"""""""""""""""""""""""""""""""""""""""
syntax on
set t_Co=256
set background=dark
set termguicolors
colorscheme hackerman
" colorscheme archman
"""""""""""""""""""""""""""""""""""""""
" GENERAL EDITING
"""""""""""""""""""""""""""""""""""""""
" remap Esc key
imap jk <Esc>
imap kj <Esc>
" no backup files
set nobackup
set nowritebackup
set autowrite
set noswapfile
" return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" delete trailing white spaces when saving
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

"if has("autocmd")
"    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.c,*.cpp :call CleanExtraSpaces()
"endif

" avoid adding \n at the end of the file (just for company purpose, it's actually a good practice to keep one)
set nofixeol

" some changes on noremap to navigate faster
noremap H 5h
noremap J 5j
noremap K 5k
noremap L 5l
noremap W 5w
noremap B 5b
"""""""""""""""""""""""""""""""""""""""
" USER INTERFACE
"""""""""""""""""""""""""""""""""""""""
set cursorline
set ruler
set scrolloff=15
set number
set relativenumber
set showcmd
set showmatch
set matchtime=0

set ignorecase
set incsearch
set smartcase
set hlsearch

" indent and tab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set smarttab
set expandtab
set ai
set si

" indent for special file
" autocmd FileType c,cpp setlocal expandtab shiftwidth=2 softtabstop=2 cindent
" autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent

set magic
set mouse=a

au FileType * set fo-=c fo-=r fo-=o " Remove auto-added comment leader in new lines
