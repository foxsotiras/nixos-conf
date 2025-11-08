{ pkgs, ... }:

{
  # Set of system packages.
  environment.systemPackages = with pkgs; [
    vim # vim system-wide.

    # Hunspell spell checker.
    hunspell
    hunspellDicts.en_US
    hunspellDicts.nb_NO
    hunspellDicts.ru-ru
    hunspellDicts.sv_SE
  ];

  # Overlays for some packages.
  nixpkgs.overlays = [
    (final: prev: {
      # Overlay for Vesktop. This edits Exec parameter in .desktop file.
      # Discord is blocked in my country so I need to use proxy.
      vesktop = prev.vesktop.overrideAttrs (old: {
        desktopItems = with final; [
          (makeDesktopItem {
            name = "vesktop";
            desktopName = "Vesktop";
            exec = "vesktop --proxy-server=127.0.0.1:1080 %U";
            icon = "vesktop";
            startupWMClass = "Vesktop";
            genericName = "Internet Messenger";
            keywords = [
              "discord"
              "vencord"
              "electron"
              "chat"
            ];
            categories = [
              "Network"
              "InstantMessaging"
              "Chat"
            ];
          })
        ];
      });
    })
  ];
}
