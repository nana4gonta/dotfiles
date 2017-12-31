# Platform Setting

## Darwin(OSX)
if [[ $(uname) =~ "Darwin" ]]; then
    # git
    GIT_COMPLETION_PATH="$(brew --prefix)/etc/bash_completion"

    # dircolors
    if hash gdircolors 2>/dev/null; then
      DIRCOLORS="gdircolors"
    else
      DIRCOLORS="dircolors"
    fi
    eval $($DIRCOLORS ~/.dircolors-solarized/dircolors.ansi-universal)

    # clear DNS cache
    alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

    alias ls="gls"
fi

if [[ $(uname) =~ "Linux" ]]; then
    # git
    GIT_COMPLETION_PATH="/usr/share/bash-completion/completions/git"
fi

# git
if [ -f $GIT_COMPLETION_PATH ]; then
    source $GIT_COMPLETION_PATH
fi

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\u@\h:\W\$(parse_git_branch) \$ "

# peco
peco-cd() {
    local selected
    selected="$(ghq list --full-path | peco --query="$READLINE_LINE")"
    if [ -n "$selected" ]; then
        echo $(printf "cd %s" $selected)
	pushd "$selected"
    fi
}
alias pcd="peco-cd"

peco-select-history() {  
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")  
    READLINE_LINE="$l"  
    READLINE_POINT=${#l}  
}  
#bind -x '"\C-r": peco-select-history'
#bind    '"\C-xr": reverse-search-history'

peco-git-checkout() {
  declare branch=$(git branch -a | peco | tr -d ' ')

  if [ -n "$branch" ]; then
    if [[ "$branch" =~ "remotes/" ]]; then
      declare b=$(echo $branch | awk -F'/' '{print $3}')
      declare res="git checkout -b '${b}' '${branch}'"
    else
      declare res="git checkout '${branch}'"
    fi
  fi
  READLINE_LINE="$res"
  READLINE_POINT=${#res}
}

peco-ssh() {
  local _host=$(grep -o '^\S\+' ~/.ssh/known_hosts | tr -d '[]' | tr ',' '\n' | sort | peco)
  if [ ${TMUX} ]; then
    eval $(printf "tmux neww -n %s 'ssh %s'" ${_host} ${_host})
  else
    eval $(printf 'ssh %s' ${_host})
  fi
}
alias pssh="peco-ssh"

# alias
alias ls="ls -CFG --color=auto"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
