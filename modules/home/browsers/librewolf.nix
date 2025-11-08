{ config, lib, ... }:

with lib;
let cfg = config.modules.librewolf;

in
{
  options.modules.librewolf = {
    enable = mkEnableOption "Install librewolf";
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true; # Install librewolf for user.

      # Settings to be passed to overrides.cfg.
      settings = {
        "browser.aboutConfig.showWarning" = false; # Disable about:config warning.
        "browser.tabs.inTitlebar" = 0; # Use system titlebar.

        "widget.use-xdg-desktop-portal.file-picker" = 1; # Use system xdg-desktop-portal
        "widget.use-xdg-desktop-portal.mime-handler" = 1; # and mime-handler.

        "widget.wayland.opaque-region.enabled" = false; # Wayland can cause some bugs.

        "sidebar.verticalTabs" = true; # Enable vertical tabs.
        "sidebar.verticalTabs.dragToPinPromo.dismissed" = true; # Skip promo for vertical tabs.
      };
    };
  };
}
