fish_add_path ~/.local/bin

type starship > /dev/null 2>&1 && starship init fish | source

if status --is-interactive
  set fish_color_error          red      --bold
  set fish_color_param          white
  set fish_color_command        cyan     --bold
  set fish_color_autosuggestion green
  set fish_color_operator       bryellow --bold
  set fish_color_comment        green    --bold
  set fish_color_search_match            --background=magenta
  set fish_color_escape         yellow   --bold
end

function preexec --on-event fish_preexec
  printf "\e[1m=== command begin: \e[4;33m%s\e[0m\n" (date '+%F (%a) %T')
end
function postexec --on-event fish_postexec
  printf "\e[1m=== command end: \e[4;33m%s\e[0m\n" (date '+%F (%a) %T')
end

if [ -f ~/.config/fish/env-spec.fish ]
  source ~/.config/fish/env-spec.fish
end

alias nix-fish='nix-shell --run fish'
