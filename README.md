## QuickStart

1. install these packages:
    - [git](https://git-scm.com/)
    - [Nixpkgs](https://github.com/NixOS/nixpkgs)
    - [gnu make](https://www.gnu.org/software/make/)

2. write `nixpkgs/home.nix`
    ```nix
    { config, pkgs, ... }:
    {
      home.username = "<username>";
      home.homeDirectory = "<home directory path>";
      imports = [ ./home.base.nix ];
      # ...
    }
    ```

3. run `make`
4. run `home-manager switch`

### Linux

If you use Linux, you must import `home.linux.nix` in `nixpkgs/home.nix`

```nix
# ...
imports = [ ./home.base.nix ./home.linux.nix ];
# ...
```

### macOS

If you use macOS, you must run following commands further:

```bash
make osx
```

you must add following configurations to `~/.nixpkgs/darwin-configuration.nix`:

```nix
# $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";
```

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
