
bind 'set bell-style none'
alias v='vim'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias a='fc -s ; history -d -1'

alias mcmb01='ssh -L 8080:localhost:11111 njb89@drexel.edu@mcmb-compute01.mem.drexel.edu'
alias mcmb02='ssh -L 8080:localhost:11111 njb89@drexel.edu@mcmb-compute02.mem.drexel.edu'
alias mcmb03='ssh -L 8080:localhost:11111 njb89@drexel.edu@mcmb-compute03.urcf.drexel.edu'
alias mcmb04='ssh -L 8080:localhost:11111 njb89@drexel.edu@mcmb-compute04.urcf.drexel.edu'

zz() {
    zathura $1 &
}

timeit() {
    { /usr/bin/time -f'\nCommand "%C" on %P CPU\n\tElapsed \t\t%E\n\tMax resident set size \t%M KB\n' $@ ; } 2>&1 | grep -E --color=always '^|Command|Max resident set size|Elapsed|Elapsed (wall clock)'
}

