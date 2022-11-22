## QuickStart

1. install these packages:
    - [git](https://git-scm.com/)
    - [Nixpkgs](https://github.com/NixOS/nixpkgs)
    - [gnu make](https://www.gnu.org/software/make/)

2. write `nixpkgs/home.nix`
    ```nix
    { config, pkgs, ... }:
    {
      imports = [ ./home.base.nix ];
      # ...
    }
    ```

3. run `make`
