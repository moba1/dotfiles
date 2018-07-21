execute "curl https://sh.rustup.rs -sSf | sh -s -- -y" do
    not_if "[ -e ~/.cargo/bin/rustup ]"
end
