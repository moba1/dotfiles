package "vim"

link File.expand_path("~/.vimrc") do
  to File.expand_path(File.join(File.dirname(__FILE__), "files", ".vimrc"))
  force true
end

# get dein.vim installer
dein_installer_path = "/tmp/installer.sh"
dein_installer_url = "https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh"
if not File.exist?(dein_installer_path)
  execute "get dein.vim plugin" do
    command "curl -o #{dein_installer_path} #{dein_installer_url}"
  end
end

# setup dein
dein_cache_dir = File.expand_path("~/.vim/.cache/dein")
dein_dir = File.join(dein_cache_dir, 'repos', 'github.com', 'Shougo', 'dein.vim')
directory dein_cache_dir
if not File.exist?(dein_dir)
  execute "setup dein" do
    command "sh #{dein_installer_path} #{dein_cache_dir}"
  end
end

