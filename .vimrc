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
Plugin 'tpope/vim-obsession' " Automatic session tracking
"Plugin 'tmux-plugins/vim-tmux-focus-events' "this plugin causes tmux to highlight the incorrect window
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kana/vim-smartword'
Plugin 'mileszs/ack.vim'
"Plugin 'brookhong/cscope.vim'
Plugin 'derekwyatt/vim-fswitch' " Switch between header and source
Plugin 'MattesGroeger/vim-bookmarks'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'Yggdroot/indentLine'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-abolish' " enable :%S to do case-sensitive replace
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

execute "set <xUp>=\e[1;*A"
execute "set <xDown>=\e[1;*B"
execute "set <xRight>=\e[1;*C"
execute "set <xLeft>=\e[1;*D"
execute "set <xHome>=\e[1;*H"
execute "set <xEnd>=\e[1;*F"
execute "set <PageUp>=\e[5;*~"
execute "set <PageDown>=\e[6;*~"
execute "set <F1>=\eOP"
execute "set <F2>=\eOQ"
execute "set <F3>=\eOR"
execute "set <F4>=\eOS"
execute "set <S-F1>=\e[1;2P"
execute "set <S-F2>=\e[1;2Q"
execute "set <S-F3>=\e[1;2R"
execute "set <S-F4>=\e[1;2S"
execute "set <xF1>=\e1;*P"
execute "set <xF2>=\e1;*Q"
execute "set <xF3>=\e1;*R"
execute "set <xF4>=\e1;*S"
execute "set <F5>=\e[15;*~"
execute "set <F6>=\e[17;*~"
execute "set <F7>=\e[18;*~"
execute "set <F8>=\e[19;*~"
execute "set <F9>=\e[20;*~"
execute "set <F10>=\e[21;*~"
execute "set <F11>=\e[23;*~"
execute "set <F12>=\e[24;*~"
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
":set autochdir





"-------------------- Plugins --------------------
" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" " `s{char}{label}`
" nmap <leader>f <Plug>(easymotion-prefix)
map f <Plug>(easymotion-bd-fl)
noremap F f
map t <Plug>(easymotion-bd-tl)
noremap T t
map <leader>f <Plug>(easymotion-bd-f2)
"map <leader>F <Plug>(easyomtion-F2)
map <leader>t <Plug>(easyomtion-bd-t2)
"map <leader>T <Plug>(easymotion-T2)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" NERDCommenter
map # <Plug>NERDCommenterToggle

" ctags
:ca ctags !ctags -R .
:set tags=./tags,tags;
:let generate_tags=1
:let ctags_statusline=1
nnoremap <leader>] <C-]>
nnoremap <leader>[ <C-t>
nnoremap <silent><leader>} <C-w><C-]><C-w>T
nnoremap <silent><leader>{ <C-w><C-t><C-w>T
nnoremap <leader>n :tn<CR>
nnoremap <leader>p :tp<CR>

" cscope
" s: Find this C symbol
" nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
" nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
" nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
" nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
" nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
" nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
" nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
" nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
"nnoremap  c[ :call CscopeFind('c', expand('<cword>'))<CR>
":ca cscope !~/cscope_gen.sh

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
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
:set laststatus=2
:set noshowmode
:set noshowcmd

" vim-tmux-navigator
let g:tmux_navigator_disable_when_zoomed = 1

" vim-obsession
"autocmd VimEnter * Obsess .
ca ss :Obsess .<CR>

" Fswitch
nmap <silent> <S-TAB> :FSHere<cr>

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
inoremap jk <Esc>`^
inoremap <C-H> <Esc>ldbi
inoremap <C-L> <Esc>ldwi
inoremap <C-J> <Esc>ld$i
inoremap <C-K> <Esc>ld^i
"inoremap <C-P> <C-R>+
"----------------------------------------





:ca cd. cd %:h

nnoremap $ $l
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
nnoremap ;sp :vsp<CR><C-W>l
nnoremap ;ta :vsp<CR><C-W>T
:ca lsp vsp
:ca rsp botright vsp
:ca tsp sp
:ca bsp rightbelow sp

" Resize splits
nnoremap <S-F1> :vertical resize -20<CR>
nnoremap <S-F2> :res +10<CR>
nnoremap <S-F3> :res -10<CR>
nnoremap <S-F4> :vertical resize +20<CR>

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
nnoremap <leader>* *Nyw:!ack -r <C-R>"<CR>
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
nnoremap dl ^"+d$
nnoremap yl ^"+y$
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
"nnoremap ; ,
"nnoremap ' ;

" Move current pane to new window
nnoremap <leader>t <C-w>T
" Duplicate current tab
nnoremap <leader>d :tab split<CR>
" Move through changelist instead of jumplist
"nnoremap <C-I> g,
"nnoremap <C-O> g;
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

" :tabnew and :Explore
:ca tabexp :tabnew<CR>:Explore<CR>

" Open file under cursor
nnoremap <leader><Enter> <c-w>gf

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
