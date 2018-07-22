package "fish"

[
    "~/.local/",
    "~/.local/bin",
    "~/.config",
    "~/.config/fish",
    "~/.config/fish/completions"
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

[
    [
        "~/.config/fish/config.fish",
        "/files/fish/config.fish"
    ],
    [
        "~/.config/fish/functions",
        "/files/fish/functions"
    ],
].each { |link, target|
    link File.expand_path(link) do
        to File.expand_path(File.dirname(__FILE__) + target)
        force true
    end
}

source = "https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish"
execute "sudo -u #{ENV["USER"]} curl #{source} > #{File.expand_path("~/.config/fish/completions/docker.fish")}" do
    not_if "[ -e #{File.expand_path("~/.config/fish/completions/docker.fish")} ]"
end

case node[:platform]
when "darwin"
    file File.expand_path("~/.bash_profile") do
        content "exec ~/.homebrew/bin/fish"
    end
else
    link File.expand_path("~/.bash_profile") do
        to File.expand_path(File.dirname(__FILE__) + "/files/bash_profile")
        force true
    end
end
