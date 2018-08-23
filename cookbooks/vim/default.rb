package "vim"

link File.expand_path("~/.vimrc") do
  to File.expand_path(File.join(File.dirname(__FILE__), "files", ".vimrc"))
  force true
end

rainbow_dir = "/tmp/rainbow"

git rainbow_dir do
  repository "https://github.com/luochen1990/rainbow"
end

def copy_files(root, source_dir)
  for f in Dir.glob(File.join(source_dir, "*")) do
    remote_file File.join(root, File.basename(f)) do
      source f
    end
  end
end

plugin_dir = File.expand_path("~/.vim/plugin")
directory plugin_dir
copy_files(plugin_dir, File.join(rainbow_dir, "plugin"))

autoload_dir = File.expand_path("~/.vim/autoload")
directory autoload_dir
copy_files(autoload_dir, File.join(rainbow_dir, "autoload"))

