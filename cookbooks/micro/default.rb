case node[:platform]
when "darwin"
    package "micro"
else
    group_id = "1000"
    data_dir = "~/.local"
    directory File.expand_path(data_dir) do
        not_if "[ -d #{data_dir} ]"
	mode "755"
        owner ENV["USER"]
	group group_id
    end

    binary_dir = "#{data_dir}/bin"
    directory File.expand_path(binary_dir) do
        not_if "[ -d #{binary_dir} ]"
        mode "755"
        owner ENV["USER"]
        group group_id
    end
 
    repository = "https://getmic.ro"
    execute "sudo -u #{ENV["USER"]} sh -c 'curl #{repository} | bash && mv micro #{binary_dir}'" do
        not_if "[ -e #{binary_dir}/micro ]"
    end
end

