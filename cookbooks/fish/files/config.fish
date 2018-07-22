set -gx LSCOLORS gxafcxacFxdeagDxdxCxdB

set -gx PATH ~/.local/bin ~/.cargo/bin $PATH
set -l homebrew_prefix ~/.homebrew
switch (uname)
    case Darwin
       set -gx PATH $homebrew_prefix/bin $PATH
       set -gx PATH $homebrew_prefix/sbin $PATH
end

set -gx PYTHONUSERBASE ~/.local
