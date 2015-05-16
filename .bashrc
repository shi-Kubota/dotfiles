alias ll='ls -la --color=auto'

export CLICOLOR=1
export PS1="\[\033[1;34m\][\w]\[\033[0m\]\n\[\033[1;32m\]\u@\h:\[\033[1;33m\]-> \[\033[0m\]"

if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi

