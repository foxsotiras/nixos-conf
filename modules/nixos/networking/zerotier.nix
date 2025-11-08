{ config, lib, ... }:

with lib;
let cfg = config.modules.zerotier;

in
{
  options.modules.zerotier = {
    enable = mkEnableOption "Install ZerotierOne";
  };

  config = mkIf cfg.enable {
    services.zerotierone.enable = true; # Install zerotier.

    # ZerotierOne is an unfree package so it need to be allowed.
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (getName pkg) [
        "zerotierone"
      ];
  };
}
