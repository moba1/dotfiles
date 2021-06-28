case node[:platform]
when "arch"
  # Arch Linuxでは `pacman -S vim` でインストールできる vim は
  # `-clipboard` となり、 clipboard 機能が無効化されている。
  # gvim は `+clipboard` となっていて、 clipboard 機能が
  # 有効化されているので、 gvim パッケージの方をインストールする
  package "gvim"
when "darwin"
  package "macvim"
else
  package "vim"
end
package "neovim"

files = File.join(File.dirname(__FILE__), "files")

for file in Dir.glob(File.join(files, "*")) do
  link File.join(node[:home], ".#{File.basename(file)}") do
    to file
    force true
  end
end

nvim_config_dir = File.join(node[:home], ".config", "nvim")
directory nvim_config_dir do
  user node[:username]
end
link File.join(nvim_config_dir, "init.vim") do
  to File.join(files, "vimrc")
  force true
end

vundle_dir = File.join(node[:home], ".vim", "bundle")
directory vundle_dir do
  owner node[:username]
  group node[:groupid]
end
git File.join(vundle_dir, "Vundle.vim") do
  repository "git@github.com:VundleVim/Vundle.vim.git"
  user node[:username]
end
execute "install plugin" do
  user node[:username]
  command "vim +PluginInstall +qall"
end
