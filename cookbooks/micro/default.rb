case node[:platform]
when "darwin"
    package "micro"
else
    directory File.expand_path("~/.local/bin") do
        not_if "[[ -e ~/.local/bin ]]"
    end
    execute "curl https://getmic.ro | bash && mv micro #{File.expand_path('~/.local/bin')}" do
        not_if "[[ -e ~/.local/bin/micro ]]"
    end
end
