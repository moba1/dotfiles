node.reverse_merge!(
  home: "/home/#{ENV['username']}",
  groupid: "users",
  username: ENV['username']
)

include_recipe "./common"
