set nocompatible " be iMproved, required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession' " Automatic session tracking
Plug 'dhruvasagar/vim-prosession'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'MattesGroeger/vim-bookmarks'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-abolish' " enable :%S to do case-sensitive replace
Plug 'bkad/CamelCaseMotion'  " word motion with camelcase and underscores
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'clangd/coc-clangd'
Plug 'scrooloose/nerdtree' " Nerdtree
Plug 'dense-analysis/ale'
Plug 'cespare/vim-toml'
Plug 'mg979/vim-visual-multi'
Plug 'universal-ctags/ctags'
Plug 'mbbill/undotree'
Plug 'lfv89/vim-interestingwords'
"Plug 'wellle/context.vim'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Unused plugins
"Plug 'scrooloose/syntastic'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'brookhong/cscope.vim'
"Plug 'mileszs/ack.vim'
"Plug 'tmux-plugins/vim-tmux-focus-events' "this plugin causes tmux to highlight the incorrect window
call plug#end()

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

" Disable swap file
set noswapfile
" Auto block comments
:set formatoptions-=o formatoptions-=r

" Do not hide characters in json / README
set conceallevel=0
let g:vim_json_conceal = 0
autocmd InsertEnter *.json setlocal conceallevel=0
autocmd InsertLeave *.json setlocal concealcursor=inc

" Free cursor movement
:set virtualedit=all

:set ttyfast
:set lazyredraw

:set t_Co=256
:set background=dark
:colorscheme gruvbox "bubblegum kolor zenburn jellybeans Tomorrow-Night
"hi Normal guibg=NONE ctermbg=NONE
:set relativenumber
:set hlsearch
:set incsearch
:set nowrap
:let mapleader = " "
:set cursorline
" Soft Tab
:set expandtab
:set shiftwidth=2
:set softtabstop=2
:set tabstop=2

" Never move cursor
:set nostartofline

" Make sure .zshrc is loaded
:set shellcmdflag=-ic

:set matchpairs+=<:>

" Change directory to currently editing file
":set autochdir

" Make interactive to load zshrc
" https://stackoverflow.com/questions/4642822/commands-executed-from-vim-are-not-recognizing-bash-command-aliases
":set shellcmdflag=-ic


"-------------------- Plugins --------------------
" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" " `s{char}{label}`
" nmap <leader>f <Plug>(easymotion-prefix)
map f <Plug>(easymotion-bd-fl)
map t <Plug>(easymotion-bd-tl)
map F <Plug>(easymotion-bd-f2)
map T <Plug>(easyomtion-bd-t2)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" NERDCommenter
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } }
map # <Plug>NERDCommenterToggle

" coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_disable_startup_warning = 1

" ctags
"map <C-[> <C-T> " Do not map <C-[> because it is equivalent to mapping <Esc>
map g[ <C-T>

" CamelCaseMotion
" Unmap cr used by vim-abolish for coersion: https://github.com/tpope/vim-abolish#coercion
silent! sunmap cr
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> s <Plug>CamelCaseMotion_ge
sunmap s
noremap W w
noremap B b
noremap E e
" Remap original S to I
nnoremap <leader>S S
noremap S gE
onoremap iW iw
onoremap iB ib
onoremap iE ie
onoremap iS igE
xnoremap iW iw
xnoremap iB ib
xnoremap iE ie
xnoremap iS igE
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
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
"ca ss :Obsess .<CR>

" Fswitch
"nmap <silent> <S-TAB> :FSHere<cr>

" IndentLine
let g:indentLine_char = '⦙'
let g:indentLine_enabled = 1
let g:indentLine_setColors = 1
let g:indentLine_color_gui = '#000000'
let g:indentLine_color_term = 25

" vim-indent-guides
"let g:indent_guides_auto_colors = 0
":hi IndentGuidesOdd  ctermbg=234
":hi IndentGuidesEven ctermbg=233
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_default_mapping = 0
":set ts=2 sw=2 et
"let g:indent_guides_start_level = 2

" CtrlP
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_mruf_relative = 1 "Only show mru in current working directory
"let g:ctrlp_regexp = 1 "Default regex
"let g:ctrlp_working_path_mode = '' "search entire current working directory

" fzf
" Have :Files order based on proximity: https://github.com/jonhoo/proximity-sort
function! s:list_cmd()
  return printf('find "$(pwd)" -type f | proximity-sort "%s"', expand('%:p'))
endfunction

"--------------------

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

nnoremap <C-P> :Files<CR>
nnoremap <C-S-P> :call fzf#vim#files("~", 0)<CR>
" Open file under cursor
nnoremap <leader><Enter> :call fzf#vim#files('.', {'options':'--query ' . expand('<cword>') . ' --select-1'})<CR>
nmap <S-TAB> :call fzf#run(fzf#wrap({'source': 'find . -regextype posix-extended -regex ".*/' . expand("%:t:r") . '.(h\|hh\|hpp\|c\|cc\|cpp)$" -not -name "' . expand("%:t") . '"', 'sink': 'e', 'options': '--select-1'}))<CR>
" https://github.com/junegunn/fzf.vim/issues/346
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <leader>a :Ag<CR>
nnoremap <leader>A :call fzf#vim#ag(expand('<cword>'))<CR>
nnoremap <leader>* :call fzf#vim#ag(expand('<cword>'))<CR>
" Have fzf open at the bottom
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }

" NERDTree
let NERDTreeQuitOnOpen=1
let NERDTreeCustomOpenArgs={'file': {'reuse': 'currenttab', 'where': 'p'}}

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1

" vim-bookmarks
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_highlight_lines = 1
nmap MM <Plug>BookmarkToggle
nmap MI <Plug>BookmarkAnnotate
nmap Ma <Plug>BookmarkShowAll
nmap Mn <Plug>BookmarkNext
nmap MN <Plug>BookmarkPrev
nmap Mc <Plug>BookmarkClear
nmap Mx <Plug>BookmarkClearAll
nmap Mk <Plug>BookmarkMoveUp
nmap Mj <Plug>BookmarkMoveDown
"nmap Mg <Plug>BookmarkMoveToLine

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-visual-multi
"autocmd User visual_multi_mappings xmap y "+y

" fugitive
autocmd User FugitiveObject nmap <buffer> - gT

" context
"let g:context_enabled = 0
"let g:context_max_height = 11

" undotree
nnoremap <F5> :UndotreeToggle<CR>

"----------------------------------------



"------------------- Insert Mode --------------------
inoremap jk <Esc>`^
inoremap <C-H> <Esc>ldbi
inoremap <C-L> <Esc>ldwi
inoremap <C-J> <Esc>ld$i
inoremap <C-K> <Esc>ld^i
"inoremap <C-P> <C-R>+
"----------------------------------------

set noswapfile

:ca cd. cd %:h

nnoremap $ $l
" Window Scrolling
nnoremap <C-E> <C-E>j
nnoremap <C-Y> <C-Y>k
noremap zl 8zl
noremap zh 8zh
noremap ZL 32zl
noremap ZH 32zh

" Split navigation
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-=> <C-W>=
nnoremap ;sp :vsp<CR><C-W>l
nnoremap ;ta :vsp<CR><C-W>T
nnoremap ;tn :tabnew<CR>
nnoremap ;tq :tabclose<CR>
nnoremap ;tt :vsp<CR><C-W>T:e %:h<CR>
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
nnoremap L <nop>
nnoremap K <nop>
nnoremap H <nop>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
nnoremap <leader>J J
nnoremap <leader>w :w<CR>
nnoremap <leader>W :w !sudo tee %<CR>
nnoremap <leader>q :q<CR>
nnoremap * *Nzz
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
noremap y "+y
nnoremap yy "+yy
noremap D "+d
nnoremap DD "+dd
noremap p "+p
noremap P "+P
" Yank line paste inline
nnoremap Dl ^"+d$
nnoremap dl ^d$
nnoremap yl ^"+y$
" Do not overwrite register
noremap x "_x
noremap d "_d
nnoremap dd "_dd

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
nnoremap d< F<%x``x
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

" Copy filename
nnoremap <leader>c :let @+=expand("%:t")<CR>
nnoremap <leader>C :let @+=expand("%:p")<CR>

" Moving between cursorcolumns
"noremap H 20h
"noremap L 20l

" Next / Previous find command
"nnoremap ; ,
"nnoremap ' ;

" Move through changelist instead of jumplist
"nnoremap <C-I> g,
"nnoremap <C-O> g;

nnoremap <leader>t :NERDTree %:h<CR>

" Reload
nnoremap <leader><leader> :tabdo windo source $MYVIMRC<CR>:tabdo wincmd =<CR>:tabdo windo e %<CR>:noh<CR>
:set autoread

" Set $DISPLAY variable
command! UpdateDisplay let $DISPLAY = system('cat /proc/$(pidof "gnome-terminal-server")/environ | tr "\0" "\n" | grep ^DISPLAY= | cut -d "=" -f 2')

" Show search result count
:set shortmess-=S

" Remove trailing whitespace (https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file)
nnoremap <leader>r :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" Remove trailing whitespace, Unicode (non-ASCII) characters, tabs, excess whitespace, whitespace before [,*]
"nnoremap <leader>R :%s/\s\+$//e<CR>:%s/[^[:alnum:][:punct:][:space:]]//gce<CR>:%s/\t/    /ge<CR>:%s/\([^ ]\+\)[ ]\+\([^ ]\)/\1 \2/g<CR>:%s/ \([,]\)/\1/g<CR>
" Retab
nnoremap <leader><TAB> mzgg=G`z:retab<CR>
" Open at last edit position
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif

" Undo tree navigation
:set undolevels=5000
nnoremap <C-Left> 10g-
nnoremap <C-Right> 10g+

" :tabnew and :Explore
:ca tabexp :tabnew<CR>:Explore<CR>

" ShowOrig show original file
command! ShowOrig vert new | set bt=nofile | r ++edit # | 0d_ | wincmd p

" Always sync syntax
autocmd BufEnter * :syntax sync fromstart

" Autoresize splits on window resize
:autocmd VimResized * wincmd =

" Remove cursor if out of focus
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END
"
" Do not clear clipboard on close
"autocmd VimLeave * call system('echo ' . shellescape(getreg('+')) .
            "\ ' | xclip -selection clipboard')

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

autocmd BufNewFile,BufRead *.launch set syntax=xml
