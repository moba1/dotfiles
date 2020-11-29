package "tmux"

link File.join(node[:home], ".tmux.conf") do
    to File.join(File.expand_path(File.dirname(__FILE__)), "files/tmux.conf")
    force true
end
