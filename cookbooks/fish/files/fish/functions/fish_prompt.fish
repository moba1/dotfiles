function fish_prompt --description "left prompt"
    set -l exit_code $status

    printf "[ \e[1;32m%s\e[0m%s ]\n" (prompt_pwd) (__fish_git_prompt)
    if [ $exit_code -eq 0 ]
      printf "\e[1;36m>< <(('>\e[0m .oO "
    else
      printf "\e[1;35m>< <((->\e[0m .oO "
    end
end
