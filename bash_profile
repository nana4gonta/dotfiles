export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_MESSAGES="C"
export OUTPUT_CHARSET=ja_JP.UTF-8

# set Terminal 256 color
export TERM="xterm-256color"

# ssh
echo -n "ssh-agent: "
source ~/.ssh-agent-info
ssh-add -l >&/dev/null

if [ $? == 2 ] ; then
    echo -n "ssh-agent: restart...."
    ssh-agent >~/.ssh-agent-info
    source ~/.ssh-agent-info
fi

if ssh-add -l >&/dev/null ; then
    echo "ssh-agent: Identity is already stored."
else
    ssh-add
fi

if [[ $(uname) =~ "Darwin" ]]; then
    #export PATH=$PATH:~/Developer/android-sdk-macosx/tools
    export EPREFIX="$HOME/Gentoo"
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi
    if [ -e '/usr/local/bin/brew' -a -e '/usr/local/bin/gls' ]; then
	alias ls='gls --color=auto'
    fi
    alias less='/usr/bin/less -r'
    eval $(gdircolors ~/.dircolors-solarized)
    export PATH=$(brew --prefix ruby)/bin:/usr/local/bin:$PATH
else
    alias less='/bin/less -r'
fi


function share_history {  # 以下の内容を関数として定義
    history -a  # .bash_historyに前回コマンドを1行追記
    history -c  # 端末ローカルの履歴を一旦消去
    history -r  # .bash_historyから履歴を読み込み直す
}
PROMPT_COMMAND='share_history'  # 上記関数をプロンプト毎に自動実施
shopt -u histappend   # .bash_history追記モードは不要なのでOFFに
export HISTSIZE=50000  # 履歴のMAX保存数を指定

export HISTCONTROL=ignoredups # 重複履歴を無視
export HISTIGNORE="fg*:bg*:history*:cd*:ls*:exit:tmux:*purge*"

HISTTIMEFORMAT='%Y/%m/%d %T';
export HISTTIMEFORMAT


case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/dotfiles/dircolors && eval "$(dircolors -b ~/dotfiles/dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

## create emacs env file
perl -wle \
    'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/shellenv.el

# import my ENV file
# source ~/dotfiles/shellenv
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

