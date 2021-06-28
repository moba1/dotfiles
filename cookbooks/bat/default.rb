package "bat"

bat_config_path = File.join(node[:home], ".config", "bat")

directory bat_config_path do
  user node[:username]
  group node[:groupid]
end

files = File.join(File.dirname(__FILE__), "files")

link File.join(bat_config_path, "config") do
  to File.join(files, "config")
  force true
end

