package "i3"
package "i3blocks"
package "dmenu"
package "gnome-screensaver"
package "gdm"

case node[:platform]
when 'debian', 'ubuntu', 'mint'
  pakcage "fonts-font-awesome"
when 'arch'
  package "ttf-font-awesome"
when 'redhat', 'fedora'
  package "fontawesome-fonts-web"
when 'opensuse'
  package "fontawesome-fonts"
end

config_dir = File.join(node[:home], ".config")
files_dir = File.expand_path(File.dirname(__FILE__)), "files"

link File.join(config_dir, "i3") do
  to File.join(files_dir, "i3")
  force true
end

link File.join(config_dir, "i3blocks") do
  to File.join(files_dir, "i3blocks")
  force true
end

