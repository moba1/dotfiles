case node[:platform]
when "darwin"
    package "micro"
else
    binary_dir = "~/.local/bin"
    directory File.expand_path(binary_dir) do
        not_if "[ -e #{binary_dir} ]"
    end
    repository = "https://getmic.ro"
    execute "curl #{repository} | bash && mv micro #{binary_dir}" do
        not_if "[ -e #{binary_dir} ]"
    end
end
