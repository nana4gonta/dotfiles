export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LC_MESSAGES="C"
export OUTPUT_CHARSET=ja_JP.UTF-8

# setterm -blength 0

# Platform Setting
## Darwin(OSX)
if [[ $(uname) =~ "Darwin" ]]; then
    # set Terminal 256 color
    export TERM="xterm-256color"


    # Homebrew
    export PATH=/usr/local/sbin:$PATH
    export HOMEBREW_GITHUB_API_TOKEN=1ec1759a6821e61e4108d9b2e6080a5375c5a42c

    # composer
    export PATH=$HOME/.composer/vendor/bin:$PATH

    # Go
    export GOROOT=/usr/local/opt/go/libexec/
    export GOPATH=$HOME
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

    # Java
    export JAVA_HOME=`/usr/libexec/java_home`
    
    # Mono(ASP.NET)
    export MONO_GAC_PREFIX="/usr/local"
    export MONO_MANAGED_WATCHER=false

    # Android
    export ANDROID_HOME=$HOME/Developer/android-sdk-macosx
fi

if [[ $(uname) =~ "Linux" ]]; then
    export TERM="xterm-256color"

    export GOPATH=$HOME
    export PATH=$GOPATH/bin:$PATH
fi

# anyenv
if [[ -e "$HOME/.anyenv" ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi
    

# bash history
function share_history {  # 以下の内容を関数として定義
    history -a  # .bash_historyに前回コマンドを1行追記
    history -c  # 端末ローカルの履歴を一旦消去
    history -r  # .bash_historyから履歴を読み込み直す
}
PROMPT_COMMAND='share_history'  # 上記関数をプロンプト毎に自動実施
shopt -u histappend   # .bash_history追記モードは不要なのでOFFに
export HISTSIZE=50000  # 履歴のMAX保存数を指定

export HISTCONTROL=ignoreboth # 重複履歴を無視
export HISTIGNORE="ls*:fg*:bg*:history*:cd*:builtin cd*:exit:tmux:*purge*"

HISTTIMEFORMAT='%Y%m%d %T';
export HISTTIMEFORMAT

# ssh agent
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


# less
export LESS="-imRr"

# load bashrc
test -r ~/.bashrc && . ~/.bashrc
