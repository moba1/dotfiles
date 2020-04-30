case node[:platform]
when "debian", "ubuntu", "mint"
  package "lastpass-cli"
when "arch"
  pakcage "lastpass"
else
  raise "unsupported OS: #{node[:platform]}"
end
