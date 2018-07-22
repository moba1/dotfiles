package "xonsh"

link File.expand_path("~/.xonshrc") do
    to File.expand_path(File.dirname(__FILE__) + "/files/.xonshrc")
    force true
end

bash_profile_path = "#{ENV["HOME"]}/.bash_profile"
file bash_profile_path do
    content "exec xonsh"
    owner ENV["USER"]
    group "1000"
end
