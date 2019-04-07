package "neomutt"

link File.join(node[:home], ".muttrc") do
  to File.join(File.expand_path(File.dirname(__FILE__)), "files", ".muttrc")
  force true
end

mutt_dir = File.join(node[:home], ".mutt")
mail_account_dir = File.join(mutt_dir, "account")
case node[:platform]
when 'darwin'
  directory mutt_dir
  directory mail_account_dir
else
  directory mutt_dir do
    mode "755"
    user node[:username]
    group node[:groupid]
  end
  directory mail_account_dir do
    mode "755"
    user node[:username]
    group node[:groupid]
  end
end

config_dir =File.join(File.expand_path(File.dirname(__FILE__)), "files") 
link File.join(mutt_dir, "color.muttrc") do
  to File.join(config_dir, "mutt-colors-solarized", "mutt-colors-solarized-dark-16.muttrc")
  force true
end

link File.join(mutt_dir, "bind.muttrc") do
  to File.join(config_dir, "bind.muttrc")
  force true
end
