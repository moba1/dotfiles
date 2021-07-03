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
#package "neovim"

files = File.join(File.dirname(__FILE__), "files")

for file in Dir.glob(File.join(files, "*")) do
  link File.join(node[:home], ".#{File.basename(file)}") do
    to file
    force true
  end
end

vim_plug_dirs = [
  File.join(node[:home], ".vim", "autoload", "plug.vim"),
  File.join(node[:home], ".local", "share", "nvim", "site", "autoload", "plug.vim")
]
for vim_plug_dir in vim_plug_dirs do
  execute "install vim-plug" do
    command "sudo -u '#{node[:username]}' curl -fLo '#{vim_plug_dir}' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
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
