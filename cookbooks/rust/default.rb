rustup_exe = File.join(node[:home], '.cargo/bin/rustup')
if not File.exist?(rustup_exe)
    execute "rustup setup" do
        command "sh -c 'curl https://sh.rustup.rs -sSf' | sh -s -- -y"
        user node[:username]
    end
end

