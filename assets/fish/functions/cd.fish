function cd
  if builtin cd $argv
    if type lsd > /dev/null 2>&1
      lsd
    else
      ls
    end
  end
end
