{ config, lib, pkgs, ... }:

with lib;
{
  # This file contains modules options for installation packages to user environment.
  # Add here options if you need to install additional packages.
  options = {
    modules.telegram.enable = mkEnableOption "Install Telegram";
    modules.vesktop.enable = mkEnableOption "Install Vesktop";
  };

  config = {
    home.packages =
      (optionals config.modules.telegram.enable [ pkgs.telegram-desktop ]) ++
      (optionals config.modules.vesktop.enable [ pkgs.vesktop ]);
  };
}
