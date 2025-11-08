{ ... }:

{
  imports = [
    ./hardware-configuration.nix # Import your hardware configuration here.
    ../../modules/nixos
  ];

  # Setup hostname.
  networking.hostName = "arctic-laptop";

  # Enable modules for host.
  modules = {
    # Change default /etc/hosts.
    networking.patches.enable = true;

    # Enable btrfs filesystem. Edit mount options by yourself.
    btrfs = {
      enable = true;
      autoScrub.enable = true;
      ssd = true;
    };

    # Enable tlp. Check tlp.nix for enabled options.
    tlp.enable = true;

    # Enable chrony. You can use timesyncd which is enabled by default.
    chrony.enable = true;

    # Enable docker. Docker module will enable btrfs storage driver if btrfs is enabled.
    # Otherwise docker will use overlay2 by default.
    docker.enable = true;

    # Enable zerotier. Only for vlan sake.
    # Also zerotierone is unfree package.
    zerotier.enable = true;

    # I need this to use internet basically.
    xray.enable = true;
  };

  # Do not touch.
  system.stateVersion = "25.05"; # Did you read the comment?
}
