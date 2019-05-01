function fish_prompt --description "left prompt"
    set -l exit_code $status
    set -l git_prompt (__fish_git_prompt)

    printf "[ \e[1;32m%s\e[0m%s ]\n" (prompt_pwd) $git_prompt
    printf "\e[1;93m$USER@%s\e[0m%s > " (hostname | cut -d . -f 1) ([ $exit_code -ne 0 ]; and echo -e " \e[1;31m!!!\e[0m ")
end
