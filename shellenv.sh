## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

# set Terminal 256 color
export TERM="xterm-256color"

# color setting
alias ls="ls --color=auto"
#alias dir="dir --color=auto"
#alias vdir="vdir --color=auto"
alias rm="rm -i"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias ghcop="ghc -Wall fno-warn-unused-do-bind"
export GREP_OPTIONS="-r -I --exclude-dir=.svn --exclude-dir=.git --exclude-dir=CVS --exclude=*~"
alias less="less -MN"
export LV="-la -Ou8 -c"

if [[ $(uname) =~ "Darwin" ]]; then
    alias emacs='/Applications/Emacs-24.app/Contents/MacOS/Emacs'
    alias emacsclient='/Applications/Emacs-24.app/Contents/MacOS/bin/emacsclient -n'
    alias e='emacsclient'
    export EDITOR=emacsclient 
    alias vim="$HOME/Gentoo/usr/bin/vim"
    alias emerge="emerge -av"
    alias emergea="emerge --autounmask-write"
fi

# rvmrc
# if [[ -s /usr/local/lib/rvm ]] ; then source /usr/local/lib/rvm ; fi

# npmrc
export NODE_PATH="$HOME/.npm/libraries:$NODE_PATH"
export PATH="$HOME/.npm/bin:$PATH"
export MANPATH="$HOME/.npm/man:$MANPATH"

# cabal
export CABEL_PATH=$HOME/.cabal/bin
export PATH=$CABEL_PATH:$PATH

# Android SDK
export PATH="$HOME/Developer/android-sdk-macosx/tools:$HOME/Developer/android-sdk-macosx/platform-tools:$PATH"

# Haxe
export HAXE_PATH="$HOME/Developer/haxe-osx"
export HAXE_LIBRARY_PATH="$HAXE_PATH/std"
export PATH=$HAXE_PATH:$PATH

# Node.js
export NODE_PATH="$HOME/Gentoo/usr/lib/node_modules/"
export PATH=$NODE_PATH:$PATH

# TexLive
# Perl5 for TexLive
export TLPKG="$HOME/Gentoo/usr/share/tlpkg/TeXLive/"
export PERL5LIB=$TLPKG
# texmf-local
export TEXMFLOCAL="$HOME/Gentoo/usr/share/texmf-local"

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH

# Tell NuGet that it can package restore
export EnableNuGetPackageRestore=true 
eval "$(rbenv init -)"

# XUL SDK
export XULSDK="$HOME/Developer/xulrunnder-sdk/bin"
export PATH=$XULSDK:$PATH

# OMake
export OMAKELIB="$HOME/Gentoo/usr/lib/omake/"
