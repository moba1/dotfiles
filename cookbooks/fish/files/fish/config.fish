set -gx LSCOLORS gxafcxacFxdeagDxdxCxdB

set -gx PATH ~/.local/bin ~/.cargo/bin $PATH
set -l homebrew_prefix ~/.homebrew
switch (uname)
    case Darwin
       set -gx PATH $homebrew_prefix/bin $PATH
       set -gx PATH $homebrew_prefix/sbin $PATH
end

set -gx PYTHONUSERBASE ~/.local

set __fish_git_prompt_color_branch cyan
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind magenta
