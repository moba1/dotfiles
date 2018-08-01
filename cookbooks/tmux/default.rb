package "tmux"

link File.expand_path("~/.tmux.conf") do
	to File.expand_path(File.dirname(__FILE__) + "/files/.tmux.conf")
	force true
end
