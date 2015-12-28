## Default shell configuration
#
# set prompt
#
autoload -Uz colors
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
fi

autoload -Uz add-zsh-hook

# Set Prompt
function get_vcs_info() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[2]=$(_git_not_pushed)
    psvar[1]=$vcs_info_msg_0_
}
add-zsh-hook precmd get_vcs_info

function _git_not_pushed()
{
  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
    head="$(git rev-parse HEAD)"
    for x in $(git rev-parse --remotes)
    do
      if [ "$head" = "$x" ]; then
        return 0
      fi
    done
    echo "{?}"
  fi
  return 0
}

function print_prompt() {
    print -rP "
$fg[cyan]%n@%m$reset_color: $fg[yellow]%~ $fg[green]%1(v|$fg[green]%1v%2v%f|)${vcs_info_git_pushed}"
}
add-zsh-hook precmd print_prompt

PROMPT="-> "


# Completion configuration
setopt auto_list auto_param_slash list_packed rec_exact
unsetopt list_beep
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' use-cache true
zstyle ':completion:*' format '%F{white}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' completer _oldlist _complete _match _ignored \
    _approximate _list _history
autoload -U compinit
compinit

# Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 直前と同じコマンドはヒストリに追加しない
setopt hist_ignore_dups
# 複数端末間でヒストリの共有
setopt share_history
# スペースで始まるコマンドはヒストリに追加しない
setopt hist_ignore_space

# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5
    && ${cmd} != (l|l[sal])
    && ${cmd} != (c|cd)
    && ${cmd} != (m|man)
    ]]
}

# read user only setting
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine


# no beep
setopt NO_beep

# z
source ~/.zsh/z/z.sh
pre_z() {
      _z --add "$(pwd -P)"
}
add-zsh-hook precmd pre_z
_Z_DATA=$HOME/.zsh/z/data

# buffer stack
show_buffer_stack() {
    POSTDISPLAY="
    stack: $LBUFFER"
    zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey '^Q' show_buffer_stack

# http://d.hatena.ne.jp/pi8027/20120227/1330349071
nw(){
    local CMDNAME split_opts spawn_command
    CMDNAME=`basename $0`

    while getopts dhvPp:l:t:b: OPT
    do
        case $OPT in
            "d" | "h" | "v" | "P" )
                split_opts="$split_opts -$OPT";;
            "p" | "l" | "t" )
                split_opts="$split_opts -$OPT $OPTARG";;
            * ) echo "Usage: $CMDNAME [-dhvP]" \
                "[-p percentage|-l size] [-t target-pane] [command]" 1>&2
            return 1;;
    esac
done
shift `expr $OPTIND - 1`

spawn_command=$@
[[ -z $spawn_command ]] && spawn_command=$SHELL

tmux split-window `echo -n $split_opts` "cd $PWD ; $spawn_command"
}

_nw(){
    local args
    args=(
    '-d[do not make the new window become the active one]'
    '-h[split horizontally]'
    '-v[split vertically]'
    '-l[define new pane'\''s size]: :_guard "[0-9]#" "numeric value"'
    '-p[define new pane'\''s size in percent]: :_guard "[0-9]#" "numeric value"'
    '-t[choose target pane]: :_guard "[0-9]#" "numeric value"'
    '*:: :_normal'
    )
    _arguments ${args} && return
}

compdef _nw nw

function alc() {
if [ $# != 0 ]; then
    lynx -dump -nonumbers "http://eow.alc.co.jp/$*/UTF-8/?ref=sa" | less +38
else
    lynx -dump -nonumbers "http://www.alc.co.jp/"
fi
}

function rurima() {
if [ $# != 0]; then
    lynx -dump -nonumbers "http://doc.ruby-lang.org/ja/1.9.3/class/$*.html" | less +38
else
    lynx -dump -nonumbers "http://www.ruby-lang.org/ja/1.9.3/doc/index.html"
fi
}

## create emacs env file
perl -wle \
    'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/shellenv.el

# import my ENV file
source ~/dotfiles/shellenv.sh

# import dir_colors
LS_COLORS="$HOME/dotfiles/dircolors"
eval `dircolors --sh $LS_COLORS`


