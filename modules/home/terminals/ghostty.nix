{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.ghostty;

in
{
  options.modules.ghostty = {
    enable = mkEnableOption "Install ghostty";
    zsh = mkOption {
      type = types.bool;
      default = config.modules.zsh.enable;
      description = "Enable zsh integration for ghostty";
    };
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true; # Install ghostty terminal for user.

      # Enable some integration.
      enableZshIntegration = cfg.zsh;
      installVimSyntax = true;

      settings = {
        theme = "TokyoNight";

        # If you change font be sure to install it in fonts.nix nixos module.
        font-size = 12;
        font-family = "JetBrainsMono Nerd Font";
        font-style = "Regular";
        font-style-bold = "Bold";
        font-style-italic = "Italic";
        font-style-bold-italic = "Bold Italic";

        window-padding-x = 5;
        window-padding-y = 5;

        keybind = [
          "super+ctrl+j=write_screen_file:copy"
          "super+shift+j=write_screen_file:paste"
          "super+alt+j=write_screen_file:open"

          "ctrl+alt+comma=open_config"
          "alt+comma=reload_config"
          "alt+i=inspector:toggle"

          "ctrl+t=new_tab"
          "ctrl+w=close_tab:this"
          "ctrl+shift+w=close_surface"

          "alt+a=new_split:left"
          "alt+d=new_split:right"
          "alt+w=new_split:up"
          "alt+s=new_split:down"
          "alt+arrow_left=goto_split:left"
          "alt+arrow_right=goto_split:right"
          "alt+arrow_up=goto_split:up"
          "alt+arrow_down=goto_split:down"
          "alt+bracket_left=goto_split:previous"
          "alt+bracket_right=goto_split:next"
          "ctrl+alt+arrow_left=resize_split:left,10"
          "ctrl+alt+arrow_right=resize_split:right,10"
          "ctrl+alt+arrow_up=resize_split:up,10"
          "ctrl+alt+arrow_down=resize_split:down,10"
          "alt+e=equalize_splits"
          "ctrl+alt+enter=toggle_split_zoom"
        ];
      };
    };
  };
}
