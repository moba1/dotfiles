package "vim"

link File.join(node[:home], ".vimrc") do
    to File.join(File.expand_path(File.dirname(__FILE__)), "files", ".vimrc")
    force true
end

# get dein.vim installer
dein_installer_path = "/tmp/installer.sh"
dein_installer_url = "https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh"
if not File.exist?(dein_installer_path)
  execute "get dein.vim plugin" do
    command "curl -o #{dein_installer_path} #{dein_installer_url}"
    user node[:username]
  end
end

vim_dir = File.join(node[:home], ".vim")

# setup dein
dein_cache_dir = File.join(vim_dir, ".cache/dein")
dein_dir = File.join(dein_cache_dir, 'repos/github.com/Shougo/dein.vim')
case node[:platform]
when 'darwin'
    directory dein_cache_dir
else
    directory dein_cache_dir do
        mode "755"
        user node[:username]
        group node[:groupid]
    end
end
if not File.exist?(dein_dir)
    execute "setup dein" do
        command "sh #{dein_installer_path} #{dein_cache_dir}"
        user node[:username]
    end
end

# install color scheme
color_scheme_dir = File.join(vim_dir, "colors")
case node[:platform]
when 'darwin'
  directory color_scheme_dir
else
    directory color_scheme_dir do
        mode "755"
        user node[:username]
        group node[:groupid]
    end
end
if not File.exist?(color_scheme_dir)
    execute "setup dein" do
      command "curl https://raw.githubusercontent.com/lifepillar/vim-solarized8/master/colors/solarized8_flat.vim > #{File.join(color_vim_dir, "solarized8.vim")}"
        user node[:username]
    end
end
