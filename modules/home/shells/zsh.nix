{ config, lib, ... }:

with lib;
let cfg = config.modules.zsh;

in
{
  options.modules.zsh = {
    enable = mkEnableOption "Enable zsh shell configuration";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      # This enables zsh configuration for user. To use zsh as user shell
      # you need to use users.users.<name>.shell option.
      enable = true;

      # Change config directory to $XDG_CONFIG_HOME/zsh.
      dotDir = "${config.xdg.configHome}/zsh";

      # Enable some plugins.
      autosuggestion.enable = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;

      # Settings for history file.
      history = {
        save = 1000;
        size = 1000;
        path = "${config.xdg.cacheHome}/zsh_histfile";
      };
    };
  };
}
