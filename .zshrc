# Disable Ctrl-S freeze
stty -ixon
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory sharehistory nomatch notify hist_expire_dups_first
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
zstyle :compinstall filename '/home/rufus/.zshrc'
# Disable hostname completion
zstyle ':completion:*:(ssh|scp):hosts' hosts 'reply=()'
zstyle -e ':completion:*' hosts 'reply=()'
zstyle ':completion:*:make:*' path-completion false

source "${HOME}"/config/completion.zsh

autoload -Uz compinit
compinit -i

zmodload -i zsh/complist

# End of lines added by compinstall

# Available colors:
# black
# red
# green
# yellow
# blue
# magenta
# cyan
# white

autoload -U colors && colors
RPROMPT="%{$fg[cyan]%}%B%~%b%{$reset_color%}"
PROMPT="%{$fg[black]%}$%B%{$fg[yellow]%}>%b%{$fg[black]%}$%{$reset_color%}"

setopt promptsubst
PS1=%B%{$fg[blue]%}$'${(r:$COLUMNS::\u2501:)}'%{$reset_color%}%b$PS1

#bindkey -v
#bindkey jk vi-cmd-mode
#bindkey "^H" backward-delete-char
#bindkey "^R" history-incremental-search-backward
bindkey '\e.' insert-last-word

bindkey "^[[3~" delete-char # Delete key
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[7~" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[8~" end-of-line

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
zle -N insert-last-word

#source ~/auto-list.zsh

#TODO: Hint for ..

# Launch tmux on start
if [[ -z "$TMUX" ]]; then
    if [[ -n "$(tmux list-session | grep -v 'attached')" ]]; then
        tmux a
    else
        tmux new
    fi
fi

alias cgrep='grep -r --include="*.hpp" --include="*.cpp" --include="*.h" --include="*.c"'
alias rfind='find -name "*.h" -o -name "*.c" -o -name "*.hpp" -o -name "*.cpp" -o -name "CMakeLists.txt" -o -name "*.launch" -o -name "*.xml"'
alias cack='find -name "*.h" -o -name "*.c" -o -name "*.hpp" -o -name "*.cpp" -o -name "CMakeLists.txt" | ack --files-from=- '
alias ussh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias uscp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias ursync='rsync -e "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"'
alias ag='ag --ignore tags --ignore "*.dae" --ignore "*.obj" --ignore ".fbx"'

# Install z directory jumper
. ~/config/z/z.sh

# Use ntfy for notifying long commands
export AUTO_NTFY_DONE_IGNORE="fim vim screen meld ssh ussh gitk git-gui"
eval "$(ntfy shell-integration)"

source /opt/ros/melodic/setup.zsh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export ARM_CC="/home/rufus/arm_toolchain/gcc-linaro-6.4.1-2018.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf"
export PYTHONPATH=/opt/drake/lib/python3.6/site-packages:${PYTHONPATH}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

########## CUSTOM ALIAS & FUNCTIONS ##########

# Run fzf and open resultant file in vim
# $ fzf
fim() {
    local file
    file=$(fzf)
    [ -n "$file" ] && vim -p "$file"
}

# Similar to fim but searches file content instead of file name
# $ aim
aim() {
  local file
  local line

  read -r file line <<<"$(ag --nobreak --noheading . | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

# find file and ack pattern
# $ fack file_name pattern
fack() {
    find -name "$1" | ack -x "$2"
}

# Check memory usage of process
# $ mem /opt/google/chrome/chrome
mem() {
    smem -t -k -c pss -P "$1" | tail -n 1
}

# Simple pattern matching refactor (renames variables and file names
# $ refactor "class_name1" "class_name2"
refactor() {
    rfind | ack -xl "${1}" | xargs -I{} sed -i "s/${1}/${2}/g" {}
    rfind | xargs -I{} rename "s/${1}/${2}/" {}
}

# fd - fuzzy find directory
fd() {
    cd "${1}" && find "$(pwd)" -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m
}

# fh - fuzzy find history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed -r 's/ *[0-9]*\*? *//' | fzf -e +s --tac | sed -r 's/\\/\\\\/g')
}

# mkdir and cd
mcd() {
    mkdir "${1}" && cd "${1}"
}

# Home-wide file search
ff() {
    cd "${1}" && find "$(pwd)" -print 2>/dev/null | fzf -m
}

this_branch() {
    git branch | grep \* | cut -d ' ' -f2
}


# Setup Language Server
tag() {
    cmake -H. -B.tag -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
    ln -s .tag/compile_commands.json
}

####################

########## THIS MUST BE AT THE END ##########
source ~/.zplug/init.zsh

# List zplug plugins here
zplug "zsh-users/zsh-autosuggestions"
