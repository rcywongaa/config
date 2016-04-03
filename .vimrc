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

" Auto block comments
:set formatoptions=ro

:set t_Co=256
:colorscheme koehler
:set relativenumber
:set hlsearch
:set incsearch
:set tabstop=4
:set nowrap
:let mapleader = " "
inoremap jk <Esc>l

" Window Scrolling
nnoremap <C-E> <C-E>j
nnoremap <C-Y> <C-Y>k

nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

nnoremap ZZ <nop>
nnoremap J <nop>
noremap s <nop>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
nnoremap <leader>J J
nnoremap <leader><CR> i<CR><Esc>
nnoremap <leader>w :w<CR>/[ ]\+$<CR>``zz
nnoremap <leader>W :w !sudo tee %<CR>
nnoremap <leader>q :q<CR>
noremap * *N
nnoremap <leader>* *N:vsp<CR><C-W>l
" Search from clipboard
nnoremap <leader>/ /<C-R>+
" Search for visually selected text
vnoremap // y/<C-R>"<CR>
" Unhighlight
nnoremap // :noh<CR>
" Copy to clipboard
nnoremap <leader>y "*y
nnoremap <leader>d "*d
nnoremap <leader>p "*p
nnoremap <leader>P "*P
vnoremap <leader>y "*y
vnoremap <leader>d "*d
vnoremap <leader>p "*p
vnoremap <leader>P "*P
" Do not overwrite register
nnoremap x "_x
nnoremap D "_d
" Replace brackets
nnoremap <leader>{[ F{%r]``r[
nnoremap <leader>{( F{%r)``r(
nnoremap <leader>[{ F[%r}``r{
nnoremap <leader>[( F[%r)``r(
nnoremap <leader>([ F(%r]``r[
nnoremap <leader>({ F(%r}``r{
nnoremap d( F(%x``x
nnoremap d[ F[%x``x
nnoremap d{ F{%x``x
" Comment line
nnoremap <leader>% ^i%<Esc>
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
nnoremap J gT
nnoremap K gt
nnoremap H 20h
nnoremap L 20l
nnoremap <leader>h :tabm -1<CR>
nnoremap <leader>l :tabm +1<CR>
nnoremap <leader><leader> :mapclear<CR>:source $MYVIMRC<CR>:e %<CR>

" Save session
map <F2> :mksession session.vim<CR>
" Load session
map <F3> :source session.vim<CR>
" Remove session
map <F4> :!rm session.vim<CR>

" Remove trailing whitespace, Unicode (non-ASCII) characters, tabs, excess whitespace, whitespace before [,*]
nnoremap <leader>r :%s/\s\+$//e<CR>:%s/[^[:alnum:][:punct:][:space:]]//gce<CR>:%s/\t/    /ge<CR>mzgg=G`z:retab<CR>:%s/\([^ ]\+\)[ ]\+\([^ ]\)/\1 \2/g<CR>:%s/ \([,]\)/\1/g<CR>
" Open at last edit position
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif

" Soft Tab
:set expandtab
:set shiftwidth=4
:set softtabstop=4

" Navigation guides
:set colorcolumn=20,40,60,80,100,120,140,160
:hi ColorColumn guibg=#000000 ctermbg=Black
:hi CursorLine guibg=#000000 cterm=NONE ctermbg=Black
:hi CursorColumn guibg=#000000 cterm=NONE ctermbg=Black
:set cursorline
":set cursorcolumn

:hi StatusLine ctermbg=Red
:set laststatus=2
:set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"

" Automatically resize
:autocmd VimResized * ^W=
