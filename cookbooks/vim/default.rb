include_recipe "../common/attribute.rb"

package "vim"

home_dir =
    case node[:platform]
    when 'darwin'
        node[:home][:mac]
    else
        node[:home][:other]
    end

link File.join(home_dir, ".vimrc") do
    to File.join(File.expand_path(File.dirname(__FILE__)), "files/.vimrc")
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

# setup dein
dein_cache_dir = File.join(home_dir, ".vim/.cache/dein")
dein_dir = File.join(dein_cache_dir, 'repos/github.com/Shougo/dein.vim')
directory dein_cache_dir
if not File.exist?(dein_dir)
    execute "setup dein" do
        command "sh #{dein_installer_path} #{dein_cache_dir}"
        user node[:username]
    end
end

