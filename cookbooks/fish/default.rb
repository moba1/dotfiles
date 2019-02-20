package "fish"

current_dir = File.expand_path(File.dirname(__FILE__))

dirs = [".local", ".local/bin", ".config", ".config/fish", ".config/fish/completions"]
dirs.each { |target_dir|
    dir = File.join(node[:home], target_dir)
    case node[:platform]
    when 'darwin'
        directory dir
    else
        directory dir do
            mode "755"
            user node[:username]
            group node[:groupid]
        end
    end
}


[
    [
        ".config/fish/config.fish",
        "files/fish/config.fish"
    ],
    [
        ".config/fish/functions",
        "files/fish/functions"
    ],
].each { |origin, dest|
    link File.join(node[:home], origin) do
        to File.join(current_dir, dest)
        force true
    end
}

docker_script_url = "https://raw.githubusercontent.com/docker/cli/master/contrib/completion/fish/docker.fish"
install_path = File.join(node[:home], ".config/fish/completions/docker.fish")
if not File.exist?(install_path)
    execute "install docker.fish" do
        command "curl -o #{install_path} #{docker_script_url}" 
        user node[:username]
    end
end

link File.join(node[:home], ".bash_profile") do
    to File.join(current_dir, "files/.bash_profile")
    force true
end

