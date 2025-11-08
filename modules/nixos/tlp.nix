{ config, lib, ... }:

with lib;
let cfg = config.modules.tlp;

in
{
  options.modules.tlp = {
    enable = mkEnableOption "Enable tlp";
  };

  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;

      settings = {
        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        DISK_IOSCHED = "mq-deadline mq-deadline";
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "default";
        USB_EXCLUDE_PHONE = 1;
        START_CHARGE_THRESH_BAT0 = 80;
        STOP_CHARGE_THRESH_BAT0 = 90;
        START_CHARGE_THRESH_BAT1 = 80;
        STOP_CHARGE_THRESH_BAT1 = 90;
      };
    };
  };
}
