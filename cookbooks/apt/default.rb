execute "apt update" do
    only_if "[ -n \"$(apt list --upgradeable | grep -v \"Listing... Donw\")\" ]"
end
