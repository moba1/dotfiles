package "xonsh"

link File.expand_path("~/.xonshrc") do
    to File.expand_path(File.dirname(__FILE__) + "/files/.xonshrc")
    force true
end

case node[:platform]
when "darwin"
    execute "echo \'exec ~/.homebrew/bin/xonsh\' >> ~/.bash_profile" do
        not_if "grep \"~/.homebrew/bin/xonsh\" ~/.bash_profile"
    end
when "ubuntu"
    bash_profile_path = "#{ENV["HOME"]}/.bash_profile"
    execute "echo 'exec xonsh' >> #{bash_profile_path}" do
        not_if "grep 'exex xonsh' #{bash_profile_path}"
    end
end
