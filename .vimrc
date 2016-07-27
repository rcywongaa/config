set nocompatible " be iMproved, required
filetype off " required

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
Plugin 'easymotion/vim-easymotion'

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

" Auto block comments
:set formatoptions-=o formatoptions-=r

" Free cursor movement
:set virtualedit=all

:set ttyfast
:set lazyredraw

:set t_Co=256
:colorscheme koehler
:set relativenumber
:set hlsearch
:set incsearch
:set tabstop=4
:set nowrap
:let mapleader = " "
inoremap jk <Esc>l
:hi TabLineFill ctermfg=Gray ctermbg=Black
:hi TabLine ctermfg=White ctermbg=Black
:hi TabLineSel ctermfg=Black ctermbg=White

" Change directory to currently editing file
:set autochdir

" Window Scrolling
nnoremap <C-E> <C-E>j
nnoremap <C-Y> <C-Y>k
noremap zl 10zl
noremap zh 10zh

" Split navigation
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
:ca rvsp botright vsp
:ca bsp rightbelow sp

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
nnoremap <leader>* *N:vsp<CR><C-W>l
nnoremap N Nzz
nnoremap n nzz
nnoremap < <<
nnoremap > >>
" Search from clipboard
nnoremap <leader>/ /<C-R>+
" Search for visually selected text
vnoremap * y/<C-R>"<CR>
" Search for bad whitespace
nnoremap <leader>$ /[ ]\+$<CR>``zz
" Unhighlight
nnoremap // :noh<CR>
" Copy to clipboard
nnoremap <leader>y "+y
nnoremap <leader>d "+d
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>y "+y
vnoremap <leader>d "+d
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" Yank line paste inline
nnoremap dl ^d$
nnoremap yl ^y$
" Do not overwrite register
noremap x "_x
noremap D "_d
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
nnoremap <leader>10 10gt
nnoremap <leader>11 11gt
nnoremap <leader>12 12gt
nnoremap <leader>13 13gt
nnoremap <leader>14 14gt
nnoremap <leader>15 15gt
nnoremap <F6> gT
nnoremap [ gT
nnoremap ] gt
nnoremap <F7> gt
nnoremap <F5> :tabm -1<CR>
nnoremap <F8> :tabm +1<CR>
" Moving between cursorcolumns
noremap ; 20h
noremap ' 20l
noremap H 5h
noremap L 5l

" Reload
nnoremap <leader><leader> :mapclear<CR>:tabdo windo source $MYVIMRC<CR>:tabdo wincmd =<CR>:tabdo windo e %<CR>
:set autoread

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
:hi ColorColumn ctermbg=Black
:hi CursorLine cterm=NONE ctermbg=Black
:hi CursorColumn cterm=NONE ctermbg=Black
:set cursorline
":set cursorcolumn

:hi StatusLine ctermbg=Blue
:set laststatus=2
:set statusline="%f%m%r%h%w [%Y] [0x%02.2B]%< %F%=%4v,%4l %3p%% of %L"

:set undolevels=5000

" EasyMotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" " `s{char}{label}`
" nmap \ <Plug>(easymotion-prefix)
nmap \ <Plug>(easymotion-overwin-f)

" ctags
:set tags=./tags,tags;
:let generate_tags=1
:let ctags_statusline=1




" ShowOrig show original file
command! ShowOrig vert new | set bt=nofile | r ++edit # | 0d_ | wincmd p

" WatchForChanges
" If you are using a console version of Vim, or dealing
" with a file that changes externally (e.g. a web server log)
" then Vim does not always check to see if the file has been changed.
" The GUI version of Vim will check more often (for example on Focus change),
" and prompt you if you want to reload the file.
"
" There can be cases where you can be working away, and Vim does not
" realize the file has changed. This command will force Vim to check
" more often.
"
" Calling this command sets up autocommands that check to see if the
" current buffer has been modified outside of vim (using checktime)
" and, if it has, reload it for you.
"
" This check is done whenever any of the following events are triggered:
" * BufEnter
" * CursorMoved
" * CursorMovedI
" * CursorHold
" * CursorHoldI
"
" In other words, this check occurs whenever you enter a buffer, move the cursor,
" or just wait without doing anything for 'updatetime' milliseconds.
"
" Normally it will ask you if you want to load the file, even if you haven't made
" any changes in vim. This can get annoying, however, if you frequently need to reload
" the file, so if you would rather have it to reload the buffer *without*
" prompting you, add a bang (!) after the command (WatchForChanges!).
" This will set the autoread option for that buffer in addition to setting up the
" autocommands.
"
" If you want to turn *off* watching for the buffer, just call the command again while
" in the same buffer. Each time you call the command it will toggle between on and off.
"
" WatchForChanges sets autocommands that are triggered while in *any* buffer.
" If you want vim to only check for changes to that buffer while editing the buffer
" that is being watched, use WatchForChangesWhileInThisBuffer instead.
"
command! -bang WatchForChanges :call WatchForChanges(@%, {'toggle': 1, 'autoread': <bang>0})
command! -bang WatchForChangesWhileInThisBuffer :call WatchForChanges(@%, {'toggle': 1, 'autoread': <bang>0, 'while_in_this_buffer_only': 1})
command! -bang WatchForChangesAllFile :call WatchForChanges('*', {'toggle': 1, 'autoread': <bang>0})
" WatchForChanges function
"
" This is used by the WatchForChanges* commands, but it can also be
" useful to call this from scripts. For example, if your script executes a
" long-running process, you can have your script run that long-running process
" in the background so that you can continue editing other files, redirects its
" output to a file, and open the file in another buffer that keeps reloading itself
" as more output from the long-running command becomes available.
"
" Arguments:
" * bufname: The name of the buffer/file to watch for changes.
" Use '*' to watch all files.
" * options (optional): A Dict object with any of the following keys:
" * autoread: If set to 1, causes autoread option to be turned on for the buffer in
" addition to setting up the autocommands.
" * toggle: If set to 1, causes this behavior to toggle between on and off.
" Mostly useful for mappings and commands. In scripts, you probably want to
" explicitly enable or disable it.
" * disable: If set to 1, turns off this behavior (removes the autocommand group).
" * while_in_this_buffer_only: If set to 0 (default), the events will be triggered no matter which
" buffer you are editing. (Only the specified buffer will be checked for changes,
" though, still.) If set to 1, the events will only be triggered while
" editing the specified buffer.
" * more_events: If set to 1 (the default), creates autocommands for the events
" listed above. Set to 0 to not create autocommands for CursorMoved, CursorMovedI,
" (Presumably, having too much going on for those events could slow things down,
" since they are triggered so frequently...)
function! WatchForChanges(bufname, ...)
    " Figure out which options are in effect
    if a:bufname == '*'
        let id = 'WatchForChanges'.'AnyBuffer'
        " If you try to do checktime *, you'll get E93: More than one match for * is given
        let bufspec = ''
    else
        if bufnr(a:bufname) == -1
            echoerr "Buffer " . a:bufname . " doesn't exist"
            return
        end
        let id = 'WatchForChanges'.bufnr(a:bufname)
        let bufspec = a:bufname
    end
    if len(a:000) == 0
        let options = {}
    else
        if type(a:1) == type({})
            let options = a:1
        else
            echoerr "Argument must be a Dict"
        end
    end
    let autoread = has_key(options, 'autoread') ? options['autoread'] : 0
    let toggle = has_key(options, 'toggle') ? options['toggle'] : 0
    let disable = has_key(options, 'disable') ? options['disable'] : 0
    let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
    let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0
    if while_in_this_buffer_only
        let event_bufspec = a:bufname
    else
        let event_bufspec = '*'
    end
    let reg_saved = @"
    "let autoread_saved = &autoread
    let msg = "\n"
    " Check to see if the autocommand already exists
    redir @"
    silent! exec 'au '.id
    redir END
    let l:defined = (@" !~ 'E216: No such group or event:')
    " If not yet defined...
    if !l:defined
        if l:autoread
            let msg = msg . 'Autoread enabled - '
            if a:bufname == '*'
                set autoread
            else
                setlocal autoread
            end
        end
        silent! exec 'augroup '.id
        if a:bufname != '*'
            "exec "au BufDelete ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
            "exec "au BufDelete ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
            exec "au BufDelete ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
        end
        exec "au BufEnter ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI ".event_bufspec . " :checktime ".bufspec
        " The following events might slow things down so we provide a way to disable them...
        " vim docs warn:
        " Careful: Don't do anything that the user does
        " not expect or that is slow.
        if more_events
            exec "au CursorMoved ".event_bufspec . " :checktime ".bufspec
            exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
        end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
end
" If they want to disable it, or it is defined and they want to toggle it,
if l:disable || (l:toggle && l:defined)
    if l:autoread
        let msg = msg . 'Autoread disabled - '
        if a:bufname == '*'
            set noautoread
        else
            setlocal noautoread
        end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
end
"echo msg
let @"=reg_saved
endfunction

:WatchForChanges

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif

" Speed up loading large files
" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
" setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction
