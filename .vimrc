execute pathogen#infect()
mapclear
nmapclear
imapclear
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set autoindent		" always set autoindenting on
set nowrap			" always set no wordwrap
set nobackup		" do not keep a backup file, use versions instead
set history=100		" keep 100 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set laststatus=2
set path=./,../inc,./inc,../../inc
set wildmenu "Turn on WiLd menu
"set nolazyredraw "Don't redraw while executing macros 

" When pressing <leader>cd switch to the directory of the open buffer
" nnoremap <leader>cd :cd %:p:h<cr>

" auto change dir except /tmp
"set autochdir
"autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif

noremap <SPACE> <nop>
:let mapleader=" "
noremap <space>is <nop>
" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" ctags prefer csope
":set tags+=../tags,./tags,./../tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags,./../../../../../../tags,./../../../../../../../tags
":set tags+=tags;
":set nocst
":set tags=./tags;/prj
set tags=./tags,tags;$HOME


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


set scrolloff=1     " keep 1 lines when scrolling
set cursorline
set shiftwidth=4
set tabstop=4
set expandtab

"set guifont=Inconsolata\ 13
set guifont=Monaco\ 11
"set guifont=Consolas\ 12
"set guifont=mingliu\ 12

"map <silent> <F11> :set guifont=Monaco\ 10<cr>
"map <silent> <F12> :set guifont=Monaco\ 11<cr>
"map <silent> <F12> :set guifont= <cr>

"""""""""""""""""""""""""""
" Font size macro
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

map <silent> <F11> :SmallerFont<cr>
map <silent> <F12> :LargerFont<cr>



" color
set t_Co=256
set bg=dark
colorscheme ir_black
syntax on

:function! ReverseBackground()
: let Mysyn=&syntax
: if &bg=="light"
: se bg=dark
: highlight Normal guibg=black guifg=white
: else
: se bg=light
: highlight Normal guibg=white guifg=black
: endif
: syn on
: exe "set syntax=" . Mysyn
": echo "now syntax is "&syntax
:endfunction
:command! Invbg call ReverseBackground()
":noremap <F7> :Invbg<CR>
call ReverseBackground()
call ReverseBackground()
":Invbg
":Invbg

" plugin: indent guides
let g:indent_guides_auto_colors = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#201000 ctermbg=3 
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#301800 ctermbg=4 
let g:indent_guides_enable_on_vim_startup = 1


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\<'.expand('<cword>').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction



" Search highlight
hi Search guibg=Red guifg=black
set hlsearch
:nnoremap <F3> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR> :echo 'Highlight: <C-R>=expand("<cword>")<CR>' <CR>



"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
":inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
":set dictionary="/usr/dict/words"


" NAVIGATE LONG LINES IN VIM
:map <Up> gk
:map <Down> gj

""""""""""""""""""""""""""""""
" Tag list (ctags)
""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Process_File_Always = 1
let Tlist_Highlight_Tag_On_BufEnter = 0
"let Tlist_Display_Prototype = 1

noremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
noremap <silent> <F8> :TlistToggle<cr>
noremap <silent> <F9> :TagbarToggle<cr>

let NERDTreeWinPos = 'right'
noremap <silent> <F10> :NERDTreeToggle<cr>



" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
function! ToggleDiffOrig()
  let winnum = bufwinnr(".DiffBuffer")
  if winnum != -1
    bd {[.DiffBuffer]}
    diffoff
    return 0
  else
    let filetype=&ft
	vert new .DiffBuffer | set bh=wipe noswf bt=nofile
    r #
	0d_ | diffthis
	exe "set ro ft=" . filetype
    wincmd p | diffthis
    return 1
  endif
endfunction

command! DiffOrig vert new DiffBuffer | set bh=wipe noswf bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis
map <silent> <F4> :call ToggleDiffOrig() <cr>



"""""""""""""""""""""""
" git related
"""""""""""""""""""""""
function! ToggleDiffGit()
  let winnum = bufwinnr("fugitive://")
  if winnum != -1
    bd{fugitive://}
    :diffoff
    return 0
  else
    :Gdiff
    return 1
  endif
endfunction
map <silent> <F5> :call ToggleDiffGit() <cr>

function! ToggleBlameGit()
  let winnum = bufwinnr("fugitiveblame")
  if winnum != -1
    bd{fugitiveblame}
    return 0
  else
    :Gblame
    return 1
  endif
endfunction
map <silent> <F6> :call ToggleBlameGit() <cr>

"map <silent> <F5> :Gdiff <cr>
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set statusline=%<%n\:%f\ %h%m%r%-20.([%{Tlist_Get_Tagname_By_Line()}]%)%=%-.{fugitive#statusline()}\ %-16.(\L\:%l/%L\ \C\:%v%)
hi statusline guibg=green guifg=black gui=bold


noremap :gs :Gstatus<cr>
noremap :gc :Gcommit<cr>
noremap :gl :Glog<cr>
noremap :gd :Gdiff <cr>
noremap :gb :Gblame<cr>

nnoremap ZZ <nop>
inoremap jk <Esc>l
nnoremap <C-J> <C-E>j
nnoremap <C-K> <C-Y>k
nnoremap <C-H> zhh
nnoremap <C-L> zll
nnoremap * *N
nnoremap <leader>/ /<C-R>+
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>h :tabm-1<CR>
nnoremap <leader>l :tabm+1<CR>
nnoremap <leader><PageUp> gT
nnoremap <leader><PageDown> gt
nnoremap <leader><leader> :source $MYVIMRC<CR>
"noremap <Up> <C-W>k
"noremap <Left> <C-W>h
"noremap <Right> <C-W>l
"noremap <Down> <C-W>j
nnoremap <leader>P "+P
nnoremap <leader>p "+p
nnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap x "_x
nnoremap D "_d
vnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>d "+d
nnoremap <leader><CR> o<Esc>

set noscrollbind
set nocursorbind
set number
set norelativenumber
if 0
set relativenumber
augroup relative_numbering
    autocmd!
    autocmd InsertEnter * :set number
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
    autocmd InsertLeave * :set nonumber
augroup end
endif
