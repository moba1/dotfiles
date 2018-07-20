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

def tlmgr()
    tmp = "find . -iname tlmgr | grep bin | xargs"
    case node[:platform]
    when "darwin"
        tmp = "#{tmp} -J"
    when "linux"
        tmp = "#{tmp} -I"
    end
    "#{tmp}@ @"
end

execute "#{tlmgr()} update --self --all"
execute "#{tlmgr()} paper a4"
execute "#{tlmgr()} install collection-japanese cjk latexmk biber graphcx"
