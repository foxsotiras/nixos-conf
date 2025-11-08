{ config, lib, ... }:

with lib;
let cfg = config.modules.docker;

in
{
  options.modules.docker = {
    enable = mkEnableOption "Install docker";

    # This option is needed for setting btrfs storage driver.
    btrfs = mkOption {
      type = types.bool;
      default = config.modules.btrfs.enable;
      description = "Enable docker btrfs storage driver";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true; # Install docker.
      rootless.enable = true; # Make docker rootless.
    };

    # Option to use btrfs storage driver or not. Separate subvolume is recommended.
    virtualisation.docker.storageDriver = mkIf cfg.btrfs "btrfs";
    fileSystems."/var/lib/docker".options = mkIf cfg.btrfs [ "noatime" "compress=zstd" ];
  };
}
