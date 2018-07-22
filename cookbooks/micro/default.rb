case node[:platform]
when "darwin"
    package "micro"
else
    binary_dir = "~/.local/bin"
    group_id = 1000
    directory File.expand_path(binary_dir) do
        not_if "[ -e #{binary_dir} ]"
        mode "755"
        owner ENV["USER"]
        group group_id
    end
    repository = "https://getmic.ro"
    execute "curl #{repository} | bash && chown #{ENV["USER"]}:#{group_id} micro && mv micro #{binary_dir}" do
        not_if "[ -e #{binary_dir}/micro ]"
    end
end
