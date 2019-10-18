link File.join(node[:home], ".config", "git") do
  to File.join(File.expand_path(File.dirname(__FILE__)), "files")
  force true
end

