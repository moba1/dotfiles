set -gx LSCOLORS gxafcxacFxdeagDxdxCxdB

set -gx PATH ~/.local/bin ~/.cargo/bin $PATH

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

set -l CUSTOM_FISH_FILE "~/.config/fish/custom.fish"
if ls $CUSTOM_FISH_FILE >/dev/null 2>&1
  source $CUSTOM_FISH_FILE
end

# set color
set fish_color_error red --bold
set fish_color_param white
set fish_color_command cyan --bold
set fish_color_autosuggestion green
set fish_color_operator bryellow --bold
set fish_color_comment green --bold
set fish_color_search_match --background=magenta
set fish_color_escape yellow --bold

# for pyenv
if type pyenv > /dev/null 2>&1
  set -gx PYENV_ROOT ~/.pyenv
  status --is-interactive; and pyenv init - | source
  status --is-interactive; and pyenv virtualenv-init - | source
end

alias cat bat
alias bcat hexyl

set -l node_bin ~/.node_modules/bin
if test -d $node_bin
  set -gx PATH   $PATH
  set -gx npm_config_prefix ~/.node_modules
end

set -l local_config ~/.config/fish/functions/local.fish
if test -f $local_config
  source $local_config
end

if test -n "$SSH_CONNECTION"
  set -x TERM xterm-256color
end

if type -q opam
  eval (opam config env)
end
