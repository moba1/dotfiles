install_dir = "~/.tex"

directory File.expand_path(install_dir) do
    not_if "[[ -d #{install_dir} ]]"
end

source = "/tmp/install-tl-*"
execute "rm -Rf #{source}" do
    only_if "[[ -d #{source} ]]"
end

mirror = "http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
execute "curl -L #{mirror} | tar zxvf - -C /tmp" do
    only_if "[[ -z \"$(ls -A #{install_dir})\" ]]"
end

profile = File.expand_path("~/.setup/cookbooks/texlive/files/texlive.profile")
repository = "http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/"
execute "cd #{source}; #{source}/install-tl -repository #{repository} -q -profile #{profile}" do
    only_if "[[ -z \"$(ls -A #{install_dir})\" ]]"
end

execute "rm -Rf #{source}" do
    only_if "[[ -d #{source} ]]"
end

tlmgr_path = "find #{install_dir} -iname tlmgr | grep bin | xargs"
case node[:platform]
when "darwin"
    tlmgr_path = "#{tlmgr_path} -J"
else
    tlmgr_path = "#{tlmgr_path} -I"
end
tlmgr_path = "#{tlmgr_path}@ @"

execute "#{tlmgr_path} update --self --all" do
    not_if "#{tlmgr_path} update --self --all --dry-run | grep \"no changes will be made\""
end
execute "#{tlmgr_path} paper a4" do
    not_if "#{tlmgr_path} paper | grep a4"
end
[
    "collection-langjapanese",
    "cjk",
    "latexmk",
    "biber",
    "graphics",
].each { |package|
    execute "#{tlmgr_path} install #{package}" do
        not_if "#{tlmgr_path} list --only-installed | grep -q #{package}"
    end
}
