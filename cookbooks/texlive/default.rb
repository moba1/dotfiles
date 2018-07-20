directory File.expand_path("~/.tex") do
    not_if "[[ -d ~/.tex ]]"
end

execute "curl -L http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar zxvf - -C /tmp" do
    only_if "[[ -z \"$(ls -A ~/.tex)\" ]]"
end
execute "cd install-tl-unix; env TEXLIVE_INSTALL_PREFIX=~/.tex /tmp/install-tl-*/install-tl -repository http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/ -q -profile #{File.expand_path("~/.setup/cookbooks/texlive/files/texlive.profile")}" do
    only_if "[[ -z \"$(ls -A ~/.tex)\" ]]"
end
execute "rm -Rf /tmp/install-tl-*" do
    only_if "[[ -d /tmp/install-tl* ]]"
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

# case node[:platform]
# when "Darwin"
    #execute "find . -iname tlmgr | grep bin | xargs -J@ @ update --self --all"
    #execute "find . -iname tlgmr | grep bin | xargs -J@ @ paper a4"
# when "Linux"
    #execute "find . -iname tlmgr | grep bin | xargs -I@ @ update --self --all"
    #execute "find . -iname tlmgr | grep bin | xargs -I@ @ update --self --all"
# end
