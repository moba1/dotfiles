function fish_greeting
  printf "Hello, \e[1;34m%s!\e[0m\n" "$USER"
  echo
  printf "\e[1;4;37mSystem Information:\e[0m\n"
  printf "  Host Name:    \e[1;31m%s\e[0m\n"    (uname -n)
  printf "  OS:           \e[1;33m%s %s\e[0m\n" (uname -s) (uname -r)
  printf "  Architecture: \e[1;32m%s\e[0m\n"    (uname -m)
end
