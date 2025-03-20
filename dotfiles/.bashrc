
bind 'set bell-style none'

unset rc                                                                                          
function color_my_prompt {
    local __orange="\[\033[0;32m\]"
    local __cyan="\[\033[0;36m\]"
    local __ps_clear="\[\033[00m\]"
    local __user_host_location="[\u@\h \w]"
    local __this_dir="/\W"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail=" $ "
    export PS1="$__orange$__user_host_location $__cyan$__git_branch$__ps_clear \n$__orange$__this_dir$__prompt_tail$__ps_clear"
}
color_my_prompt
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
