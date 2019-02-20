node.reverse_merge!(
  home: "/Users/#{ENV['USER']}"
)

include_recipe "../cookbooks/homebrew/default"
include_recipe "./common"
