case node[:platform]
when "debian", "ubuntu", "mint", "arch"
  package "lastpass-cli"
else
  raise "unsupported OS: #{node[:platform]}"
end
