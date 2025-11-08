{ config, lib, ... }:

with lib;
let cfg = config.modules.fastfetch;

in
{
  options.modules.fastfetch = {
    enable = mkEnableOption "Install fastfetch";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true; # Install fastfetch for user.
    };
  };
}
