package "neomutt"

link File.join(node[:home], ".muttrc") do
  to File.join(File.expand_path(File.dirname(__FILE__)), "files", ".muttrc")
  force true
end

mutt_dir = File.join(node[:home], ".mutt")
case node[:platform]
when 'darwin'
  directory mutt_dir
else
  directory mutt_dir do
    mode "755"
    user node[:username]
    group node[:groupid]
  end
end
