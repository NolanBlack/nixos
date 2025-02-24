
bind 'set bell-style none'

unset rc                                                                                          
orange=$'\033[0;32m'                                                                           
cyan=$'\033[0;36m'                                                                           
ps_clear=$'\033[0m'                                                                            
# add git branch to ps1
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
};
#export PS1="${orange}[\u@\h \w]${cyan}${ps_clear}\n ${orange}/\W $ ${ps_clear}"
export PS1='${orange}[\u@\h \w]${cyan}$(parse_git_branch)${ps_clear}\n ${orange}/\W $ ${ps_clear}'
# add nix-shell to PS1
if [[ -n "$IN_NIX_SHELL" ]]; then
    export PS1="${orange}(nix-shell) $PS1"
fi

export HISTCONTROL=ignoredups # ignore duplicates in history


# source files of form .bashrc_*
path="./"
for file in $path.bashrc_*
do 
    if [ -f "$file" ];
    then
        . $file
        echo "loaded $file"
    fi
done
