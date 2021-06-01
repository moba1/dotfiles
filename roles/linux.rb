node.reverse_merge!(
  home: "/home/#{ENV['username']}",
  groupid: ENV['groups'],
  username: ENV['username']
)

include_recipe "./common"

