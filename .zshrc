# Disable Ctrl-S freeze
stty -ixon
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory sharehistory nomatch notify HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
unsetopt autocd beep correct
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

alias ls='ls --color=auto'

# Avoid slowdown when completing git files
__git_files () {
    _wanted files expl 'local files' _files
}

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*:*:ps:*' ignored-patterns '*'
zstyle ':completion:*' insert-unambiguous true
zstyle :compinstall filename '/home/rwong/.zshrc'
# Disable hostname completion
zstyle ':completion:*:(ssh|scp):hosts' hosts 'reply=()'
zstyle -e ':completion:*' hosts 'reply=()'
zstyle ':completion:*:make:*' path-completion false

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors
RPROMPT="%{$fg[cyan]%}%B%~%b%{$reset_color%}"
PROMPT="%B%{$fg[red]%}=%{$fg[yellow]%}=%{$fg[green]%}=%{$fg[cyan]%}=%{$fg[blue]%}=%{$fg[magenta]%}=%{$fg[black]%}> %{$reset_color%}%b"

bindkey -e
bindkey "^[[3~" delete-char # Delete key
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[7~" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[8~" end-of-line

IGNORE=("tar" "make" "gitk" "yum" "apt-get" "ps" "git" "zypper")

shouldTrim=1
#Refer to http://mimosa-pudica.net/src/incr-0.2.zsh
trim_list(){
    if [[ ${compstate[list_lines]} -gt 10 && shouldTrim -gt 0 ]]; then
        compstate[list]=""
        zle -M "${compstate[nmatches]} matches..."
    elif [[ ${compstate[list_lines]} -eq 0 ]]; then
        zle -M ""
    fi
    shouldTrim=1
}

#Handle ignore list for auto-complete
function shouldComplete
{
    if [[ ${#BUFFER} -lt 2 || "${=BUFFER: -1}" == " " ]]; then
        zle -M ""
        return 0
    fi
    if [[ ${(w)#BUFFER} -gt 2 ]]; then
        for ignore in "${IGNORE[@]}"; do
            buffer=(${=BUFFER})
            if [[ "${buffer[1]}" == "${ignore}" || ("${buffer[1]}" == "sudo" && "${buffer[2]}" == "${ignore}") ]]; then
                zle -M ""
                return 0
            fi
        done
    fi
    return 1
}

function self-insert
{
    zle .self-insert
    shouldComplete
    ret=$?
    if [[ "${ret}" == 0 ]]; then
        return
    fi
    comppostfuncs=(trim_list)
    zle list-choices
}
function magic-space
{
    zle .magic-space
    shouldComplete
    ret=$?
    if [[ "${ret}" == 0 ]]; then
        return
    fi
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
    shouldComplete
    ret=$?
    if [[ "${ret}" == 0 ]]; then
        return
    fi
    comppostfuncs=(trim_list)
    zle list-choices
}
function expand-or-complete
{
    # compinit redefines the expand-or-complete function and bind it to complete-word
    zle complete-word
    shouldTrim=0
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

#TODO: Hint for ..

# Launch tmux on start
if [ "$TMUX" = "" ]; then tmux; fi

alias vim='gvim -v'
