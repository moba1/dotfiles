execute "curl https://sh.rustup.rs -sSf | sh -s -- -y" do
    not_if "[[ -e #{File.expand_path("~/.cargo/bin/rustup")} ]]"
end
