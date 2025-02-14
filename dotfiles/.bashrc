bind 'set bell-style none'

unset rc                                                                                          
ORANGE='\[\033[0;32m\]'                                                                           
CYAN='\[\033[0;36m\]'                                                                           
PS_CLEAR='\[\033[0m\]'                                                                            
# add git branch to ps1
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="${ORANGE}[\u@\h \w]${CYAN}$(parse_git_branch)${PS_CLEAR}\n ${ORANGE}/\W $ ${PS_CLEAR}"
# add nix-shell to PS1
if [[ -n "$IN_NIX_SHELL" ]]; then
    export PS1="${ORANGE}(nix-shell) $PS1"
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

