set -gx LSCOLORS gxafcxacFxdeagDxdxCxdB

set -gx PATH ~/.local/bin ~/.cargo/bin $PATH
set -l homebrew_prefix ~/.homebrew

set -gx PYTHONUSERBASE ~/.local

# for git
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch cyan
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind magenta
set __fish_git_prompt_show_informative_status 'yes'
## status characters
set __fish_git_prompt_char_upstream_prefix '.'
set __fish_git_prompt_char_upstream_ahead 'A'
set __fish_git_prompt_char_upstream_behind 'B'
set __fish_git_prompt_char_stateseparator ':'
set __fish_git_prompt_char_dirtystate 'm'
set __fish_git_prompt_char_invalidstate 'x'
set __fish_git_prompt_char_stagedstate 'M'
set __fish_git_prompt_char_untrackedfiles 'U'
set __fish_git_prompt_char_cleanstate 'clean'
set __fish_git_prompt_char_stashstate '^'
set __fish_git_prompt_describe_style 'branch'

# exec fish
test -z "$TMUX"; and exec tmux; set -gx TERM xterm-256color
