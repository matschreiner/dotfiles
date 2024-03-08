if [ -z "$SSH_AUTH_SOCK" ]; then
    eval `ssh-agent -s`
    ssh-add ~/.ssh/gitlab.pub > /dev/null 2>&1
fi
