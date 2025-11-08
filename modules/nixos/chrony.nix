{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.chrony;

in
{
  options.modules.chrony = {
    enable = mkEnableOption "Enable chrony time sync service";
  };

  config = mkIf cfg.enable {
    services.chrony = {
      enable = true; # Install chrony.
      enableRTCTrimming = false; # Disable control of system clock.

      # Set 4 server pools with options.
      servers = [];
      extraConfig = concatStringsSep "\n" [
        "pool 0.nixos.pool.ntp.org iburst maxsources 5 minpoll 12 maxpoll 14 offline"
        "pool 1.nixos.pool.ntp.org iburst maxsources 5 minpoll 12 maxpoll 14 offline"
        "pool 2.nixos.pool.ntp.org iburst maxsources 5 minpoll 12 maxpoll 14 offline"
        "pool 3.nixos.pool.ntp.org iburst maxsources 5 minpoll 12 maxpoll 14 offline"
        "minsources 5"
        "rtcsync" # This option for setting system clock to RTC.
      ];
    };

    # This is custom script for NetworkManager to enable/disable chrony with network changes.
    networking.networkmanager.dispatcherScripts = [{
      source = pkgs.writeText "chrony-onoffline" ''
        #!/bin/sh
        chronyc=${pkgs.chrony}/bin/chronyc
        if [ $# -ge 2 ]; then
          case "$2" in
            up|down|connectivity-change)
              ;;
            dhcp4-change|dhcp6-change)
              ;;
            *)
              exit 0;;
          esac
        fi
        $chronyc onoffline > /dev/null 2>&1
        exit 0
      '';
    }];
  };
}
