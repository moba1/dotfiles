homebrew_prefix = "~/.homebrew"
repository = "https://github.com/Homebrew/homebrew/tarball/master"

execute "mkdir -p #{homebrew_prefix} && curl -L #{repository} | tar xz --strip 1 -C #{homebrew_prefix}" do
    not_if "[[ -e #{homebrew_prefix}/bin/brew ]]"
end

execute "#{homebrew_prefix}/bin/brew update"
