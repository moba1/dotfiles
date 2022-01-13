function enter_ls
  set -l cmd (commandline)
  if test -z "$cmd"
    echo
    preexec
    ls
    # remove `ls`'s new line output
    printf "\033[1A"
  end
  commandline -f execute
end
