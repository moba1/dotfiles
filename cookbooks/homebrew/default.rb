homebrew_prefix = "~/.homebrew"
repository = "https://github.com/Homebrew/homebrew/tarball/master"

brew = "#{homebrew_prefix}/bin/brew"
execute "mkdir -p #{homebrew_prefix} && curl -L #{repository} | tar xz --strip 1 -C #{homebrew_prefix}" do
    not_if "[[ -e #{brew} ]]"
end

execute "#{brew} update" do
    only_if "brew install 2>&1 | grep -i \"error: unknown command\""
end
