include_recipe "../common/attribute.rb"

home_dir =
    case node[:platform]
    when 'darwin'
        node[:home][:mac]
    else
        node[:home][:other]
    end

rustup_exe = File.join(home_dir, '.cargo/bin/rustup')
if not File.exist?(rustup_exe)
    execute "rustup setup" do
        command "sh -c 'curl https://sh.rustup.rs -sSf | sh -s -- -y'"
        user node[:user]
    end
end
