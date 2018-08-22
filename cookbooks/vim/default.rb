package "vim"

link File.expand_path("~/.vimrc") do
	to File.expand_path(File.join(File.dirname(__FILE__), "files", ".vimrc"))
	force true
end
