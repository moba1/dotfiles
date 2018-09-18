home_dir =
  case node[:platform]
  when 'darwin'
    node[:home][:mac]
  else
    node[:home][:other]
  end
current_dir = File.expand_path(File.dirname(__FILE__))

package "npm"
package "node"

link File.join(home_dir, ".npmrc") do
  to File.join(current_dir, "files", ".npmrc")
  force true
end

