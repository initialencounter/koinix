# koinix

使用 nix 来构建你的 koishi

# Usage

快速体验:

```nix
nix run github:Anillc/koinix
```


构建你自己的 koishi:

```nix
{
  inputs.koinix.url = "github:Anillc/koinix";
  outputs = { koinix, ... }: {
    packages.x86_64-linux.default = koinix.lib.x86_64-linux.buildKoishi {
      host = "0.0.0.0";
      port = 8080;
      plugins = {
        console = {};
        sandbox = {};
        echo = {};
      };
    };
  };
}
```

## install nix
```shell
sh <(curl -L https://nixos.org/nix/install) --daemon
```
## setup
```shell
mkdir -p ~/.config/nix && touch ~/.config/nix/nix.conf
vi ~/.config/nix/nix.conf
# 写入
experimental-features = nix-command
```
```shell
nix flake update  --extra-experimental-features flakes
nix build --extra-experimental-features flakes
nix run --extra-experimental-features flakes
```

# Cachix

```
https://anillc.cachix.org
anillc.cachix.org-1:VmWDYKHoDiT0CKs+6daDcTz3Ur+gkw4k0kcHIeF6dF8=
```
