echo -n "ssh-agent: "
if test -e ~/.ssh-agent-info
    source ~/.ssh-agent-info
end

ssh-add -l > /dev/null ^&1
if test $status = 2
    echo -n "ssh-agent: restart...."
    ssh-agent -c | sed 's/^echo/#echo/' > ~/.ssh-agent-info
    source ~/.ssh-agent-info
end

if ssh-add -l > /dev/null ^&1
    echo "ssh-agent: Identity is already stored."
else
    ssh-add
end