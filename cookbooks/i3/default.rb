package "i3"
package "i3blocks"
package "dmenu"
package "gnome-screensaver"
package "gdm"
package "sysstat"
package "pulseaudio"
package "mailnag"

case node[:platform]
when 'debian', 'ubuntu', 'mint'
  package "fonts-font-awesome"
  package "fonts-hack-ttf"
  package "pulseaudio-utils"
when 'arch'
  package "ttf-font-awesome"
  package "ttf-hack"
when 'redhat', 'fedora'
  package "fontawesome-fonts-web"
  package "hack-fonts"
when 'opensuse'
  package "fontawesome-fonts"
  package "hack-fonts"
when 'gentoo'
  package "media-fonts/fontawesome"
  package "media-fonts/hack"
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

if node[:platform] == 'arch'
  package "dunst"

  link File.join(config_dir, "dunst") do
    to File.join(files_dir, "dunst")
    force true
  end
end

