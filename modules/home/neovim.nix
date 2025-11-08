{ config, lib, ... }:

with lib;
let cfg = config.modules.neovim;

in
{
  options.modules.neovim = {
    enable = mkEnableOption "Install neovim";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true; # Install neovim for user.
      defaultEditor = true; # Set it as default editor.

      # Alias neovim to vi and vim.
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
