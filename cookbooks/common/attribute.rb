user_name = "mob_a"

node.reverse_merge!(
    home: {
        mac: "/Users/#{user_name}",
        other: "/home/#{user_name}"
    }
)

node.reverse_merge!(
    groupid: "1000"
)

node.reverse_merge!(
    username: user_name
)

