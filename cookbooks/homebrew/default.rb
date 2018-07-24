install_script = "https://raw.githubusercontent.com/Homebrew/install/master/install"
homebrew_prefix = "/usr/local"
brew = "#{homebrew_prefix}/bin/brew"

execute "echo | /usr/bin/ruby -e \"$(curl -fsSL #{install_script})\"" do
    not_if "which brew"
end

execute "#{brew} update" do
    only_if "brew install 2>&1 | grep -i \"error: unknown command\""
end

directory "#{homebrew_prefix}/sbin"
