include_recipe "../common/attribute.rb"

package "tmux"

home_dir =
    case node[:platform]
    when 'darwin'
        node[:home][:mac]
    else
        node[:home][:other]
    end

link File.join(home_dir, ".tmux.conf") do
    to File.join(File.expand_path(File.dirname(__FILE__)), "files/.tmux.conf")
    force true
end
