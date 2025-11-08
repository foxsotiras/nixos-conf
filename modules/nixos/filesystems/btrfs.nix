{ config, lib, ... }:

with lib;
let cfg = config.modules.btrfs;

in
{
  # Create options for btrfs filesystem.
  options.modules.btrfs = {
    enable = mkEnableOption "Enable btrfs filesystem";
    autoScrub.enable = mkEnableOption "Enable btrfs automatic scrubbing";
    ssd = mkEnableOption "Enable SSD optimizations";
  };

  config = mkIf cfg.enable {
    # Here is mount options. You can use the same subvolumes or change it.
    fileSystems = {
      "/".options = [ "noatime" "compress=zstd" ];
      "/home".options = [ "noatime" "compress=zstd" ];
      "/nix".options = [ "noatime" "compress=zstd" ];
      "/swap".options = [ "noatime" ];
      "/var/log".options = [ "noatime" "compress=zstd" ];
    };

    # Enable swapfile on start.
    swapDevices = [{ device = "/swap/swapfile"; }];

    # Enable automatic scrubbing of filesystem.
    services.btrfs.autoScrub = mkIf cfg.autoScrub.enable {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/" ];
    };

    # Enable fstrim only if discard=async is not enabled by default.
    services.fstrim.enable = !cfg.ssd;
  };
}
