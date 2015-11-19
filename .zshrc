# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch notify HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
unsetopt autocd beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

# Avoid slowdown when completing git files
__git_files () { 
    _wanted files expl 'local files' _files     
}

zstyle ':completion:*' completer _complete _ignored 
zstyle ':completion:*' insert-unambiguous true
zstyle :compinstall filename '/home/rwong/.zshrc'
# Disable hostname completion
zstyle ':completion:*:(ssh|scp):hosts' hosts 'reply=()'
zstyle -e ':completion:*' hosts 'reply=()'
zstyle ':completion:*:make:*' path-completion false

autoload -Uz compinit
compinit
# End of lines added by compinstall

RPROMPT="%B%~%b"
PROMPT="→ "

bindkey -e
bindkey "^[[3~" delete-char # Delete key
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

IGNORE=("tar" "make")

#Refer to http://mimosa-pudica.net/src/incr-0.2.zsh
trim_list(){
    if [[ ${compstate[list_lines]} -gt 10 ]]; then
        compstate[list]=""
        zle -M "${compstate[nmatches]} matches..."
    fi
}

function self-insert
{
    zle .self-insert
    if [[ ${(w)#BUFFER} -gt 1 ]]; then
        for ignore in "${IGNORE[@]}"; do
            buffer=(${=BUFFER})
            if [[ "${buffer[1]}" == "${ignore}" ]]; then
                zle -M ""
                return
            fi
        done
    fi
    comppostfuncs=(trim_list)
    zle list-choices
}
function magic-space
{
    zle .magic-space
    comppostfuncs=(trim_list)
    zle list-choices
}
function backward-delete-char
{
    zle .backward-delete-char
    if [[ ${#BUFFER} -lt 1 ]]; then
        zle -M ""
        return
    fi
    comppostfuncs=(trim_list)
    zle list-choices
}
function expand-or-complete
{
    # compinit redefines the expand-or-complete function and bind it to complete-word
    zle complete-word
    comppostfuncs=(trim_list)
    zle list-choices
}

word_pos=-1
cmd_pos=-1
word_count=0
offset=1
function insert-last-word
{
    zmodload -i zsh/parameter
    zle .insert-last-word -- ${cmd_pos} ${word_pos}
    buffer=${history[`expr $HISTNO - $offset`]}
    word_count=${(w)#history[`expr $HISTNO - $offset`]}
    word_pos=`expr "${word_pos}" - 1`
    if [[ `expr 0 - $word_pos` -gt $word_count ]]; then
        word_pos=-1
        cmd_pos=-1
        #while [[ ${history[`expr $HISTNO - $offset`]} == ${history[`expr $HISTNO - $offset - 1`]} ]]; do
            offset=`expr "${offset}" + 1`
        #done
    else
        cmd_pos=0
    fi
}

zle -N self-insert
zle -N magic-space
zle -N backward-delete-char
zle -N expand-or-complete
zle -N insert-last-word

precmd () { print -Pn "\e]2;%n@%M | %~\a" }
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]l%~\e\\"
        ;;
        *xterm*|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
        ;;
    esac
}

#TODO: Ignore list for completion
#TODO: Hint for ..
#TODO: Alt-. to cycle through previous arguments
