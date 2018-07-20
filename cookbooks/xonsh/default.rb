package "xonsh"

link File.expand_path("~/.xonshrc") do
    to File.expand_path("~/.setup/cookbooks/xonsh/files/.xonshrc")
    force true
end

case node[:platform]
when "darwin"
    execute "echo \'exec ~/.homebrew/bin/xonsh\' >> ~/.bash_profile" do
        not_if "grep \"~/.homebrew/bin/xonsh\" ~/.bash_profile"
    end
end
