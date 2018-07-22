package "fish"

[
    "~/.local/",
    "~/.local/bin",
    "~/.config",
    "~/.config/fish",
].each { |package|
    case node[:platform]
    when "darwin"
        directory File.expand_path(package)
    else
        directory File.expand_path(package) do
            mode "755"
            user ENV["USER"]
            group "1000"
        end
    end
}

link File.expand_path("~/.config/fish/config.fish") do
    to File.expand_path(File.dirname(__FILE__) + "/files/config.fish")
    force true
end

case node[:platform]
when "darwin"
    file File.expand_path("~/.bash_profile") do
        content "exec ~/.homebrew/bin/fish"
    end
else
    file File.expand_path("~/.bash_profile") do
        content "exec fish"
        mode "755"
        user ENV["USER"]
        group "1000"
    end
end
