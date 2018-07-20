execute "mkdir -p #{File.expand_path('~/.homebrew')} && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C #{File.expand_path('~/.homebrew')}" do
    not_if "[[ -e #{File.expand_path('~/.homebrew/bin/brew')} ]]"
end

execute "brew update" do
    not_if "[[ -z \"$(~/.homebrew/bin/brew outdated)\" ]]"
end
