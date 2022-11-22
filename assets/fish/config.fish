set -l nix_profile ~/.nix-profile/etc/profile.d/nix.fish
if [ -e "$nix_profile" ]
  source "$nix_profile"
  set -x NIX_PATH ~/.nix-defexpr/channels
  if status --is-login
    exec fish
  end
end

if type starship >/dev/null 2>&1
  starship init fish | source
end

alias diff=delta
alias ls=lsd

set -l CUSTOM_FISH_FILE ~/.config/fish/custom.fish
if ls "$CUSTOM_FISH_FILE" >/dev/null 2>&1
  source "$CUSTOM_FISH_FILE"
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

function preexec --on-event fish_preexec
  printf "\e[1mexecute time: \e[4;33m%s\e[0m\n" (date '+%F (%a) %T')
end
