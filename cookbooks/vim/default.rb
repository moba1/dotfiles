package "vim"
package "neovim"

vimrc_path = File.join(File.expand_path(File.dirname(__FILE__)), "files", ".vimrc")
link File.join(node[:home], ".vimrc") do
    to vimrc_path
    force true
end
nvim_config_dir = File.join(node[:home], ".config", "nvim")
directory nvim_config_dir do
  user node[:username]
end
link File.join(nvim_config_dir, "init.vim") do
  to vimrc_path
  force true
end

vundle_dir = File.join(node[:home], ".vim", "bundle")
directory vundle_dir do
  owner node[:username]
  group node[:groupid]
end
git File.join(vundle_dir, "Vundle.vim") do
  repository "https://github.com/VundleVim/Vundle.vim"
  user node[:username]
end
