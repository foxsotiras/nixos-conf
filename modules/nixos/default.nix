{ ... }:

{
  imports = [
    ./chrony.nix
    ./docker.nix
    ./filesystems
    ./fonts.nix
    ./networking
    ./pkgs.nix
    ./system.nix
    ./tlp.nix
    ./users
  ];
}
