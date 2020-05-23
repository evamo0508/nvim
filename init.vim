"""""""""""""""""""""""""""""""""""""
" PLUGIN
""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim " set runtime path
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " required

Plugin 'scrooloose/nerdtree'
Plugin 'ericcurtin/CurtineIncSw.vim'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

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
set signcolumn=yes
set updatetime=300
set shortmess+=c

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
nnoremap <silent> ? :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
"""""""""""""""""""""""""""""""""""""""
"" tagbar
autocmd FileType c,cpp nested :TagbarOpen " open tagbar only for specific filetypes
nmap <F8> :TagbarToggle<CR>
"""""""""""""""""""""""""""""""""""""""
"" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"""""""""""""""""""""""""""""""""""""""
" COLORS AND FONTS
"""""""""""""""""""""""""""""""""""""""
syntax enable
set t_Co=256
set background=dark
set termguicolors
colorscheme hackerman
"""""""""""""""""""""""""""""""""""""""
" GENERAL EDITING
"""""""""""""""""""""""""""""""""""""""
" remap Esc key
imap jk <Esc>
imap kj <Esc>
" no backup files
set nobackup
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

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.c,*.cpp,*.h,*.hpp :call CleanExtraSpaces()
endif
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
autocmd FileType c,cpp setlocal expandtab shiftwidth=2 softtabstop=2 cindent
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent

set magic
set mouse=a

au FileType * set fo-=c fo-=r fo-=o " Remove auto-added comment leader in new lines
