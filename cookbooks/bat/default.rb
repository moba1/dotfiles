include_recipe "../rust/default"

execute "install bat" do
  command "#{ENV['HOME']}/.cargo/bin/cargo install --force bat"
  user node[:username]
end
