set nocompatible " be iMproved, required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugin 'scrooloose/syntastic'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-obsession'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kana/vim-smartword'
Plugin 'mileszs/ack.vim'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'Yggdroot/indentLine'

" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Fix tmux arrow key mapping
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Auto block comments
:set formatoptions-=o formatoptions-=r

" Free cursor movement
:set virtualedit=all

:set ttyfast
:set lazyredraw

:set t_Co=256
:colorscheme Tomorrow-Night "bubblegum kolor zenburn jellybeans Tomorrow-Night
:set relativenumber
:set hlsearch
:set incsearch
:set tabstop=4
:set nowrap
:let mapleader = " "
:set cursorline

" Change directory to currently editing file
:set autochdir





"-------------------- Plugins --------------------
" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" " `s{char}{label}`
" nmap <leader>f <Plug>(easymotion-prefix)
map f <Plug>(easymotion-fl)
map F <Plug>(easymotion-Fl)
map t <Plug>(easymotion-tl)
map T <Plug>(easymotion-Tl)
map <leader>f <Plug>(easymotion-f2)
map <leader>F <Plug>(easyomtion-F2)
map <leader>t <Plug>(easyomtion-t2)
map <leader>T <Plug>(easymotion-T2)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" NERDCommenter
map # <Plug>NERDCommenterToggle

" ctags
:set tags=./tags,tags;
:let generate_tags=1
:let ctags_statusline=1
nnoremap <leader>] <C-]>
nnoremap <leader>[ <C-t>
nnoremap <leader>n :tn<CR>
nnoremap <leader>p :tp<CR>

" smartword
map W <Plug>(smartword-w)
map B  <Plug>(smartword-b)
map E  <Plug>(smartword-e)

" airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
:set laststatus=2
:set noshowmode
:set noshowcmd

" vim-tmux-navigator
let g:tmux_navigator_disable_when_zoomed = 1

" vim-obsession
autocmd VimEnter * Obsess .
ca QA :Obsess!<CR>:qa<CR>

" IndentLine
"let g:indentLine_char = '⦙'
"let g:indentLine_enabled = 1
"let g:indentLine_setColors = 1
"let g:indentLine_color_gui = '#000000'
"let g:indentLine_color_term = 25

" vim-indent-guides
"let g:indent_guides_auto_colors = 0
":hi IndentGuidesOdd  ctermbg=234
":hi IndentGuidesEven ctermbg=233
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_default_mapping = 0
"----------------------------------------





"------------------- Insert Mode --------------------
inoremap jk <Esc>l
inoremap <C-H> <Esc>ldbi
inoremap <C-L> <Esc>ldwi
inoremap <C-J> <Esc>ld$i
inoremap <C-K> <Esc>ld^i
inoremap <C-P> <C-R>+
"----------------------------------------





" Window Scrolling
nnoremap <C-E> <C-E>j
nnoremap <C-Y> <C-Y>k
noremap zl 20zl
noremap zh 20zh

" Split navigation
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-=> <C-W>=
:ca lsp vsp
:ca rsp botright vsp
:ca tsp sp
:ca bsp rightbelow sp
:ca cd cd %:h

" Resize splits
nnoremap <F9> :vertical resize -20<CR>
nnoremap <F11> :res +10<CR>
nnoremap <F10> :res -10<CR>
nnoremap <F12> :vertical resize +20<CR>

nnoremap ZZ <nop>
nnoremap J <nop>
noremap s <nop>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
nnoremap <leader>J J
nnoremap <leader><CR> i<CR><Esc>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w !sudo tee %<CR>
nnoremap <leader>q :q<CR>
nnoremap * *Nzz
" start in new split
nnoremap <leader>* *N:vsp<CR><C-W>l
nnoremap N Nzz
nnoremap n nzz
" Search from clipboard
nnoremap <leader>/ /<C-R>+
" Search for visually selected text
vnoremap * y/<C-R>"<CR>
" Search for bad whitespace
nnoremap <leader>$ /[ ]\+$<CR>``zz
" Unhighlight
nnoremap // :noh<CR>
" Copy to clipboard
nnoremap y "+y
nnoremap d "+d
nnoremap p "+p
nnoremap P "+P
vnoremap y "+y
vnoremap d "+d
vnoremap p "+p
vnoremap P "+P
" Yank line paste inline
nnoremap dl ^d$
nnoremap yl ^y$
" Do not overwrite register
noremap x "_x
noremap D "_d
" Move to brackets
noremap ( F(
noremap ) f)
noremap { F{
noremap } f}
noremap [ F[
noremap ] f]
" Replace brackets
nnoremap r[ %r]``r[
nnoremap r( %r)``r(
nnoremap r{ %r}``r{
nnoremap d( F(%x``x
nnoremap d[ F[%x``x
nnoremap d{ F{%x``x
nnoremap d" F"xf"x
nnoremap d' F'xf'x
nnoremap <leader>% [{

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
nnoremap - gT
nnoremap = gt
nnoremap _ :tabm -1<CR>
nnoremap + :tabm +1<CR>
" Moving between cursorcolumns
noremap H 20h
noremap L 20l

" Next / Previous find command
nnoremap ; ,
nnoremap ' ;

" Move through changelist instead of jumplist
nnoremap <C-I> g,
nnoremap <C-O> g;
" Reload
nnoremap <leader><leader> :tabdo windo source $MYVIMRC<CR>:tabdo wincmd =<CR>:tabdo windo e %<CR>:noh<CR>
:set autoread

" Remove trailing whitespace, Unicode (non-ASCII) characters, tabs, excess whitespace, whitespace before [,*]
nnoremap <leader>r :%s/\s\+$//e<CR>:%s/[^[:alnum:][:punct:][:space:]]//gce<CR>:%s/\t/    /ge<CR>:%s/\([^ ]\+\)[ ]\+\([^ ]\)/\1 \2/g<CR>:%s/ \([,]\)/\1/g<CR>
" Retab
nnoremap <leader><TAB> mzgg=G`z:retab<CR>
" Open at last edit position
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif

" Soft Tab
:set expandtab
:set shiftwidth=4
:set softtabstop=4

" Undo tree navigation
:set undolevels=5000
nnoremap <C-Left> 10g-
nnoremap <C-Right> 10g+

" ShowOrig show original file
command! ShowOrig vert new | set bt=nofile | r ++edit # | 0d_ | wincmd p

" Always sync syntax
autocmd BufEnter * :syntax sync fromstart

" Remove cursor if out of focus
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END
"
" Do not clear clipboard on close
autocmd VimLeave * call system("xsel -ib", getreg('+'))

autocmd FocusLost * call MyFocusLost()
autocmd FocusGained * call MyFocusGained()
function! MyFocusLost()
    "colorscheme monochrome
    "highlight Normal ctermbg=232
    "AirlineRefresh
    set nocul
endfunction
function! MyFocusGained()
    "colorscheme Tomorrow-Night
    "highlight Normal ctermbg=0
    "AirlineRefresh
    set cul
endfunction
