function fish_prompt
    echo -n -s "$USER@"(prompt_hostname)" "[(prompt_pwd)] (__fish_vcs_prompt) " ><(((o> "
end
