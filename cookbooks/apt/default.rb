execute "sed -i -e \"s%archive.ubuntu.com/ubuntu/%ftp.iij.ad.jp/pub/linux/ubuntu/archive/%g\" /etc/apt/sources.list" do
    not_if "[ grep ftp.iij.ad.jp /etc/apt/sources.list ]"
end

execute "apt update"

execute "apt upgrade -y" do
    only_if "[ \"$(apt list --upgradable 2>/dev/null | wc -l)\" -gt 1 ]"
end

