## QuickStart

1. install these packages:
    - [git](https://git-scm.com/)
    - [Nixpkgs](https://github.com/NixOS/nixpkgs)
    - [gnu make](https://www.gnu.org/software/make/)

1. run `make`
1. import base Nix config to `~/.config/home-manager/home.nix`
   ```nix
   imports = [ ./home.base.nix ];
   ```
1. run `home-manager switch`

### WSL
install [win32yank](https://github.com/equalsraf/win32yank) where the PATH passed

## License

<p xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <a rel="license"
     href="http://creativecommons.org/publicdomain/zero/1.0/">
    <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
  </a>
  <br />
  To the extent possible under law,
  <a rel="dct:publisher"
     href="https://github.com/moba1/dotfiles">
    <span property="dct:title">moba1</span></a>
  has waived all copyright and related or neighboring rights to
  <span property="dct:title">moba1's dotfiles</span>.
This work is published from:
<span property="vcard:Country" datatype="dct:ISO3166"
      content="JP" about="https://github.com/moba1/dotfiles">
  日本</span>.
</p>
