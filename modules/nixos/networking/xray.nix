{ config, lib, ... }:

with lib;
let cfg = config.modules.xray;

in
{
  options.modules.xray = {
    enable = mkEnableOption "Install xray vpn";
  };

  config = mkIf cfg.enable {
    services.xray = {
      enable = true; # Install xray vpn.
      settingsFile = "/etc/xray/config.json"; # Put your config in here.
    };
  };
}
