execute "apt update" do
    only_if "[ \"$(apt list --upgradable 2>/dev/null | wc -l)\" -gt 1 ]"
end

execute "apt upgrade -y" do
    only_if "[ \"$(apt list --upgradable 2>/dev/null | wc -l)\" -gt 1 ]"
end

