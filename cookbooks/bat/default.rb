if not ['debian', 'ubuntu'].include?(node[:platform])
  package 'bat'
end
