alias ll='ls -la --color=auto'

export CLICOLOR=1
export PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\]\$ "

eval `dircolors .dircolors`

export WINEDEBUG=-all
