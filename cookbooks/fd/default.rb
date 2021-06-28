case node[:platform]
when "darwin"
  package "fd"
else
  package "fd-find"
end
