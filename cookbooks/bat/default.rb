include_recipe "../rust/default"

cargo_bin = File.join(node[:home], ".cargo", "bin")

execute "install bat" do
  command "#{File.join(cargo_bin, "cargo")} install --force bat"
  user node[:username]
  not_if "stat --printf '' #{File.join(cargo_bin, "bat")}"
end

