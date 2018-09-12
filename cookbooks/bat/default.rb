case node[:platform]
when 'debian', 'ubuntu'
    bat_version = "0.6.1"
    architecture = "amd64"
    deb_package_url = "https://github.com/sharkdp/bat/releases/download/v0.6.1/bat_#{bat_version}_#{architecture}.deb"
    deb_package_path = "/tmp/bat.deb"
    if not File.exist?(deb_package_path)
        execute "get bat package" do
            command "curl -LsS -o #{deb_package_path} #{deb_package_url}"
        end
    end

    if `dpkg -l bat 2>&1` == ""
        execute "install bat package" do
            command "dpkg -i #{deb_package_path}"
        end
    end
else
    package 'bat'
end
