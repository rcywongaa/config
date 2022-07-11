# Disable Ctrl-S freeze
stty -ixon
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
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
zstyle :compinstall filename "/home/$(whoami)/.zshrc"
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
#zle -N insert-last-word smart-insert-last-word

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
bindkey '\e.' insert-last-word

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

########## exports and sources ##########

# Install z directory jumper
. ~/config/z/z.sh

# Use ntfy for notifying long commands
export AUTO_NTFY_DONE_IGNORE="fim vim nvim v ag grep screen meld ssh ussh gitk git-gui"
eval "$(ntfy shell-integration)"

export RCUTILS_CONSOLE_STDOUT_LINE_BUFFERED=1

# drake related stuff
export LD_LIBRARY_PATH="/opt/drake/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
export PATH="/opt/drake/bin${PATH:+:${PATH}}"
export PYTHONPATH="/opt/drake/lib/python$(python3 -c 'import sys; print("{0}.{1}".format(*sys.version_info))')/site-packages${PYTHONPATH:+:${PYTHONPATH}}"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

export PATH=$PATH:/home/$(whoami)/.cargo/bin
export PATH=$PATH:/home/$(whoami)/config/bin

########## CUSTOM ALIAS & FUNCTIONS ##########
# Update DISPLAY variable according to the one assigned to gnome-terminal-server
alias sudo='sudo ' # this allows us to sudo alias
alias cgrep='grep -r --include="*.hpp" --include="*.cpp" --include="*.h" --include="*.c"'
alias rfind='find -name "*.h" -o -name "*.c" -o -name "*.hpp" -o -name "*.cpp" -o -name "CMakeLists.txt" -o -name "*.launch" -o -name "*.xml" -o -name "*.yaml" -o -name "*.yml"'
alias cag='ag --cpp'
alias ussh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias uscp='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias usshfs='sshfs -o reconnect,default_permissions,ServerAliveInterval=15,ServerAliveCountMax=3 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias ursync='rsync -e "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"'
alias ag='ag --ignore tags --ignore "*.dae" --ignore "*.obj" --ignore ".fbx"'
alias v='nvim'
alias source_ros1='source /opt/ros/noetic/setup.zsh'
alias source_ros2='source /opt/ros/foxy/setup.zsh'
alias stop_ros='pkill roscore; (pkill gzserver && sleep 2 && pgrep gzserver && pkill -9 gzserver)'
alias source_zsh='source ~/.zshrc'
alias docker_gpu_run='xhost +local:docker && docker run --gpus all -v /tmp/.X11-unix/:/tmp/.X11-unix --env="DISPLAY"'
alias source_devel='source devel/setup.zsh'
alias source_install='source devel/setup.zsh'
alias disable_lfs='git config --global filter.lfs.smudge "git-lfs smudge --skip -- %f" && git config --global filter.lfs.process "git-lfs filter-process --skip"'
alias enable_lfs='git config --global filter.lfs.smudge "git-lfs smudge -- %f" && git config --global filter.lfs.process "git-lfs filter-process"'

md_to_background() {
  pandoc -V geometry:paperwidth=53.3cm -V geometry:paperheight=30cm -V geometry:margin=1cm -V fontsize=12pt "$1" -o tmp.pdf \
  && pdftoppm -jpeg -r 300 tmp.pdf cheatsheet \
  && mv cheatsheet-1.jpg ~/Pictures/ \
  && gsettings set org.gnome.desktop.background picture-uri file:////home/rufus/Pictures/cheatsheet-1.jpg \
  && rm tmp.pdf
}

force_clean() {
  disable_lfs \
  && git submodule foreach --recursive 'git clean -xfd && git stash && git reset --hard HEAD'
}

unzip_all() {
  find . -name '*.zip' -execdir sh -c 'unzip -d "${1%.*}" "$1"' sh {} \;
}

# Attempts to reattach to a branch that contains current HEAD (counteracts detached HEAD)
head_branch() {
  head="$(git rev-parse HEAD)"
  git show-ref --heads | grep $head | awk '{print $2}' | sed 's$refs/heads/$$'
}

# Run fzf and open resultant file in vim
fim() {
  local file
  # If argument is supplied, use argument as query
  if [ ! -z "$1" ]; then
    file=$(fzf -1 --exact --query="$1")
  else
    file=$(fzf -m)
  fi
  [ -n "$file" ] && nvim -p "$(echo $file | xargs)"
}

# Similar to fim but searches file content instead of file name
# $ aim
aim() {
  local file
  local line

  read -r file line <<<"$(ag --nobreak --noheading . | fzf -0 -1 | awk -F: '{print $1, $2}')"

  [ -n "$file" ] && nvim -p $(echo $file +$line | tr '\n' ' ')
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

# home-wide directory search
fd() {
    cd "${1}" && find "$(pwd)" -path '*/\.*' -prune \
      -o -type d -print 2> /dev/null | fzf +m
}

# fuzzy find history while ensuring only unique and most recently used order
h() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed -r 's/ *[0-9]*\*? *//' | \
      tac | awk '!_[$0]++' | tac | \
      fzf -e +s --tac | sed -r 's/\\/\\\\/g')
}

# Create directory and file and echo back filename for chaining
create() {
    mkdir -p "${1%/*}" && touch "${1}"
    echo "${1}"
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

# Clean ROS environment variables
ros_clean() {
    ROS_ENV_VARS="$(env | grep "ROS_\|AMENT_\|COLCON_\|CATKIN_" | egrep -o '^[^=]+' | tr -s '\n' ' ')"
    if [[ ! -z "$ROS_ENV_VARS" ]]; then
        unset ${=ROS_ENV_VARS}
    fi
    PATH=$(echo "$PATH" | perl -pe 's|(:?)/opt/ros/[^:]*|\1|')
}

function mmv()
{
    dir="$2"
    tmp="$2"; tmp="${tmp: -1}"
    [[ "$tmp" != "/" ]] && dir="$(dirname "$2")"
    [[ -a "$dir" ]] || mkdir -p "$dir" && mv "$@"
}

function drcreate()
{
    name="$(cat CONTAINER)" && bin/dr create --name "$name"
}

function drpack()
{
    if [ -z "$1" ]; then
      snapshot='develop-int-tested'
    else
      snapshot="$1"
    fi
    name="$(cat CONTAINER)" && bin/dr packages --name "$name" --freeze "$snapshot" && bin/dr packages --name "$name" --install --brain
}

function drsetup()
{
    drcreate && drpack "$1"
}

function drstop()
{
    name="$(cat CONTAINER)" && bin/dr stop --name "$name"
}

function drenter()
{
    name="$(cat CONTAINER)" && bin/dr enter --name "$name"
}

function drcomp()
{
    name="$(cat CONTAINER)" && bin/dr compile --name "$name" "$@"
}

function drclean()
{
    name="$(cat CONTAINER)" && bin/dr clean --build --name "$name"
}

alias find_errors='ag -A1 "\[gee_main-99\] has died|terminate called after throwing an instance of"' 
function tests_with_errors()
{
  ag -l -A1 "\[gee_main-99\] has died|terminate called after throwing an instance of" | awk -F '/' '{ print $1"/"$2}' | rev | cut -c 3- | rev | sort | uniq
}

function grep2()
{
  rg --multiline "$2.*(.*\n){0,$1}.*$3" | rg "$2|$3"
}

function range2()
{
  rg --multiline "$2.*(.*\n){0,$1}.*$3"
}

function rebase_submodule()
{
  if [ -z "$1" ]; then
    echo "Please provide path to submodule"
    return
  fi
  submodule_dir="$1"
  submodule_hash=$(git ls-tree HEAD "${submodule_dir}" | awk '{print $3}')
  if [ $? -ne 0 ] || [ -z "${submodule_hash}" ]; then
    echo "Could not determine submodule commit"
    return
  fi
  pushd "${submodule_dir}"
  if ! git fetch --all ; then echo "git fetch failed" ; popd ; return ; fi
  branch=$(head_branch)
  if ! git switch "${branch}" ; then ; echo "Failed switching to branch ${branch}" ; popd ; return ; fi
  if ! git rebase "${submodule_hash}" ; then ; echo "Failed rebasing ${branch} on top of ${submodule_hash}" ; popd ; return ; fi
  echo "Calling git push --force-with-lease in $(pwd)"
  git push --force-with-lease
  popd
  if ! git add "${submodule_dir}" ; then ; echo "Failed to add ${submodule_dir}" ; popd ; return ; fi
  echo "Submodule git added in $(pwd)"
}

function rebase_develop()
{
  if git fetch origin develop ; then
    if ! git rebase origin/develop ; then
      rebase_submodule ext_ws/src/ros_launch_structure
    fi
  fi
}

# Taken from https://github.com/catkin/catkin_tools/issues/551#issuecomment-553521463
function generate_compile_commands()
{
  jq -s 'map(.[])' **/compile_commands.json > compile_commands.json
}

#source /opt/ros/foxy/setup.zsh
####################

########## THIS MUST BE AT THE END ##########
source ~/.zplug/init.zsh

# List zplug plugins here
#zplug "zsh-users/zsh-autosuggestions"
