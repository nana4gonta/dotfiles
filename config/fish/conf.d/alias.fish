if pf is-darwin
    alias ls="gls -CFG --color=auto"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias flushdns='sudo dscacheutil -flushcache; and sudo killall -HUP mDNSResponder'

    # PCF
    alias cflocal='cf login -a https://api.local.pcfdev.io --skip-ssl-validation'
end
