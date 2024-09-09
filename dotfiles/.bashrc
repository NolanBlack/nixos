bind 'set bell-style none'

alias v='nvim'
alias ls='ls -a --color --group-directories-first'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias a='fc -s ; history -d -1'

alias drexelvpn='sudo openconnect --protocol=anyconnect --authgroup=DrexelVPN --user=njb89 vpn.drexel.edu'
# sometimes ssh may fail if server doesn't recognize kitty
# infocmp -a xterm-kitty | ssh myserver tic -x -o \~/.terminfo /dev/stdin
alias mcmb01='ssh -L 8080:localhost:11111 njb89@drexel.edu@mcmb-compute01.mem.drexel.edu'
alias mcmb02='ssh -L 8080:localhost:11111 njb89@drexel.edu@mcmb-compute02.mem.drexel.edu'
alias mcmb03='ssh -L 8080:localhost:11111 njb89@drexel.edu@mcmb-compute03.urcf.drexel.edu'
alias mcmb04='ssh -L 8080:localhost:11111 njb89@drexel.edu@mcmb-compute04.urcf.drexel.edu'

export PETSC_DIR='/home/nolan/petsc'
export PETSC_ARCH='arch-linux-c-opt'

zz() {
    zathura $1 &
}

timeit() {
    { /usr/bin/time -f'\nCommand "%C" on %P CPU\n\tElapsed \t\t%E\n\tMax resident set size \t%M KB\n' $@ ; } 2>&1 | grep -E --color=always '^|Command|Max resident set size|Elapsed|Elapsed (wall clock)'
}

unset rc                                                                                          
ORANGE='\[\033[0;32m\]'                                                                           
PS_CLEAR='\[\033[0m\]'                                                                            
export PS1="${ORANGE}[\u@\h \w]${PS_CLEAR}\n ${ORANGE}/\W $ ${PS_CLEAR}"
if [[ -n "$IN_NIX_SHELL" ]]; then
    export PS1="${ORANGE}(nix-shell) $PS1"
fi

