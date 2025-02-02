bind 'set bell-style none'

unset rc                                                                                          
ORANGE='\[\033[0;32m\]'                                                                           
PS_CLEAR='\[\033[0m\]'                                                                            
export PS1="${ORANGE}[\u@\h \w]${PS_CLEAR}\n ${ORANGE}/\W $ ${PS_CLEAR}"
if [[ -n "$IN_NIX_SHELL" ]]; then
    export PS1="${ORANGE}(nix-shell) $PS1"
fi


export HISTCONTROL=ignoredups # ignore duplicates in history

# source files of form .bashrc*
path="./"
for file in $path.bashrc*
do 
    if [ -f "$file" ];
    then
        . $file
        echo "loaded $file"
    fi
done

