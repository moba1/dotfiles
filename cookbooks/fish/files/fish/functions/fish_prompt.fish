function fish_prompt --description "left prompt"
    set -l exit_code $status

    printf "[ \e[1;32m%s\e[0m ]\n" (prompt_pwd)
    printf "\e[1;93m$USER@%s\e[0m%s > " (hostname | cut -d . -f 1) ([ $exit_code -ne 0 ]; and echo -e " \e[1;31m!!!\e[0m ")
end
