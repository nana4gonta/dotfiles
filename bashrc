# Platform Setting
## MSYS2
if [[ $(uname) =~ "MSYS" ]]; then
    # git
    GIT_COMPLETION_PATH="/usr/share/git/completion/git-completion.bash"
    GIT_PROMPT_PATH="/usr/share/git/completion/git-prompt.bash"
    
    # dircolors
    DIRCOLORS="dircolors"
    
fi

## Darwin(OSX)
if [[ $(uname) =~ "Darwin" ]]; then
    # git
    GIT_COMPLETION_PATH="$(brew --prefix)/etc/bash_completion"

    # dircolors
    if hash gdircolors 2>dev/null; then
      DIRCOLORS="gdircolors"
    else
      DIRCOLORS="dircolors"
    fi

    # clear DNS cache
    alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
fi


# git
if [ -f $GIT_COMPLETION_PATH ]; then
    source $GIT_COMPLETION_PATH
fi

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\u@\h:\W\$(parse_git_branch) \$ "

# dircolors
if hash $DIRCOLORS 2>/dev/null; then 
    eval $($DIRCOLORS ~/.dircolors-solarized/dircolors.ansi-universal)
fi

# direnv
eval "direnv hook bash"

# alias
alias ls="ls -CFG --color=auto"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'