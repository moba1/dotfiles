function cd
  if builtin cd $argv
    type lsd > /dev/null 2>&1; and lsd; or ls
  end
end
