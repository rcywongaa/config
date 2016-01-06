set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

:set relativenumber
:set hlsearch
:set incsearch
:set nowrap
:let mapleader = " "
inoremap jk <Esc>l

" Window Scrolling
nnoremap <C-J> <C-E>j
nnoremap <C-K> <C-Y>k
nnoremap <C-H> zhh
nnoremap <C-L> zll

nnoremap ZZ <nop>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
nnoremap <leader><CR> i<CR><Esc>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader>/ /<C-R>+
vnoremap <leader>y "+y
vnoremap <leader>d "+d
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" Search for visually selected text
vnoremap // y/<C-R>"<CR>

" Moving between tabs
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader><PAGEUP> gT
nnoremap <leader><PAGEDOWN> gt
nnoremap <leader>h :tabm -1<CR>
nnoremap <leader>l :tabm +1<CR>
nnoremap <leader><leader> :mapclear<CR>:source $MYVIMRC<CR>

" Save session
nnoremap <leader>s :mksession! session.vim<CR>

" Convenience
nnoremap <leader>= mzgg=G`z:retab<CR>
" Remove trailing whitespace, Unicode (non-ASCII) characters, tabs
nnoremap <leader>r :%s/\s\+$//e<CR>:%s/[^[:alnum:][:punct:][:space:]]//gce<CR>:%s/\t/    /ge<CR>mzgg=G`z:retab<CR>
" Open at last edit position
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif

" Soft Tab
:set expandtab
:set shiftwidth=4
:set softtabstop=4
