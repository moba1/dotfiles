rustup_exe = File.join(node[:home], '.cargo', 'bin', 'rustup')
execute "rustup setup" do
  command "sh -c 'curl https://sh.rustup.rs -sSf' | sh -s -- -y"
  user node[:username]
  not_if "stat #{rustup_exe}"
end

cargo_bin = File.join(node[:home], ".cargo", "bin")
for pack in ["bat", "hexyl", "viu"]
  execute "install #{pack}" do
    command "#{File.join(cargo_bin, "cargo")} install --force #{pack}"
    user node[:username]
    not_if "stat #{File.join(cargo_bin, pack)}"
  end
end

execute "install cargo-update" do
  command "#{File.join(cargo_bin, "cargo")} install --force cargo-update"
  user node[:username]
  not_if "cargo install-update --help"
end

