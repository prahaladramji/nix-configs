# nix-configs
Nix system configs for my personal and work system. This repo manages the common applications using nixpkgs and configurations using home-manager.

## Install
Install nix using `sh <(curl -L https://nixos.org/nix/install) --daemon`

Initial install flake from this repo.
```sh
git clone git@github.com:prahaladramji/nix-configs.git
cd nix-configs

nix build --no-link --extra-experimental-features "nix-command flakes"
nix path-info --extra-experimental-features "nix-command flakes"
```

Consecutive builds can be run by just running `make build && make activate` in this repo.

## Upgrading nix
#### Darwin
```sh
sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'
```
#### Linux
```sh
sudo -i sh -c 'nix-channel --update; nix-env -iA nixpkgs.nix nixpkgs.cacert; systemctl daemon-reload; systemctl restart nix-daemon'
```
