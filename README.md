![nix](https://socialify.git.ci/Ladas552/Flake-Ocean/image?font=Rokkitt&language=1&logo=https%3A%2F%2Fraw.githubusercontent.com%2FNixOS%2Fnixos-artwork%2Frefs%2Fheads%2Fmaster%2Flogo%2Fnix-snowflake-rainbow.svg&name=1&owner=1&pattern=Transparent&stargazers=1&theme=Dark)

# What is this?
This is my multi host, modular Nix config. It declares configs for different programs using Nix language, such as:
- [Noctalia shell](https://github.com/noctalia-dev/noctalia-shell) - desktop components with generous customizability
- [Niri](https://github.com/YaLTeR/niri) - Scrollable Tilling Wayland Compositor via Community [Niri-nix](https://codeberg.org/BANanaD3V/niri-nix) module
- And many more with [Home-manager](https://github.com/nix-community/home-manager), that allows to declare configuration of user programs in Nix language
- Excellent [Hjem](https://github.com/feel-co/hjem) linker with set of modules of [Hjem-rum](https://github.com/snugnug/hjem-rum)

I also declare configuration as packages/wrappers that you can try with `nix run
github:Ladas552/Flake-Ocean#app`, replace `app` with:

- [nvf](https://github.com/NotAShelf/nvf) - Nix declared Neovim
- [nixvim](https://github.com/nix-community/nixvim) - another Nix declared Neovim
- rofi-powermenu - power menu made of Rofi with a [nice theme](https://github.com/adi1090x/rofi)
- all the other scripts in [pkgs directory](./pkgs/default.nix)
- [wrappers directory](./modules/wrappers) for apps

# Overview of things to note

## Hosts

- 2 NixOS hosts with Nvidia and Intel, and AMD APU on laptops. Both on ZFS and NixPort is using [Impermanence](https://github.com/nix-community/impermanence)
- [Nix-On-Droid](https://github.com/nix-community/nix-on-droid) on phone, even if unmantained, it still works
- [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) for Windows partition
- NixVM for testing, you shouldn't use it unless testing breaking changes
- NixIso for my portable NixOS image
## Modular
I adopted [Dendritic layout](https://github.com/mightyiam/dendritic) for my config. 
Making all files their own modules that I can import, and if module isn't imported, it doesn't exist. This way most of my config is fairy atomic and you can pop in and out modules as you wish.

Also I made `custom.meta` options on every host, and depending on host, different variables are used. Options defined in `modules/flake-parts/options`. And host variables are defined at `imports.nix` of every host. Even for nvf and nixvim configs.

I also have a lot of unused code that I can import if need be, for example my niri can be managed with hjem and home-manager and result will be identical. 

## Docs
I write comments on things, that might explain certain ways of doing things, or leave not working options in comments for people to find. This is to not look up one thing twice, and just look at the nix file itself.

Also, I have [Norg document](./nix.norg), containing notes and TODO for the config

I also write some [blog posts about Nix](https://ladas552.me/Flake-Ocean/), feel free to check it out

## Nvfetcher

I also have inputs in `./_sources/`, they are generated with `nvfetcher` after editing the `./nvfetcher.toml` file. Instead of `nix flake update`, I update them with `nix run github:berberman/nvfetcher`.

## Screenshot if you care
![desktop](https://ladas552.me/assets/desktop/desktop.png)

## Name

Yes, it is a [JoJo's reference](https://github.com/user-attachments/assets/7c467d52-a430-4bb3-9493-a5ffa0d69dd4)

# Credits
I take a lot of things from the internet and different configs too. So I credit people in comments to snippets that I stole.

If you want to check every person that I stole things from, go to my [List of configs](https://github.com/stars/Ladas552/lists/nix-flakes)

Also for that [one guy](https://codeberg.org/Dich0tomy/snowstorm) who switched to codeberg

Also [this post from drupol](https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations/) was huge help in migrating my config to dendritic

Also, thanks to everyone in nix-community for being so awesome, wouldn't be there without ya
