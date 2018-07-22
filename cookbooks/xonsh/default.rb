package "xonsh"

link File.expand_path("~/.xonshrc") do
    to File.expand_path(File.dirname(__FILE__) + "/files/.xonshrc")
    force true
end

bash_profile_path = "#{ENV["HOME"]}/.bash_profile"
case node[:platform]
when "darwin"
    file bash_profile_path do
        content "exec ~/.homebrew/bin/xonsh"
    end
when "ubuntu"
    file bash_profile_path do
        content "exec xonsh"
        owner ENV["USER"]
        group "1000"
    end
end

def build_install_command(package)
    "xonsh -c 'xpip install --trusted-host pypi.org --trusted-host files.pythonhosted.org #{package}'"
end
case node[:platform]
when "darwin"
    execute build_install_command("ptpython") do
        not_if "xonsh -c 'xpip list' | grep ptpython"
    end
when "ubuntu"
    execute build_install_command("apt_tabcomplete") do
        not_if "xonsh -c 'xpip list' | grep apt_tabcomplete"
    end
end

execute build_install_command("docker_tabcomplete") do
    not_if "xonsh -c 'xpip list | grep docker_tabcomplete"
end

