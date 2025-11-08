{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # A list of fonts.
      jetbrains-mono

      # A list of nerd fonts.
      nerd-fonts.jetbrains-mono
    ];

    # Configuration for fonts.
    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono" ];
      };
    };
  };
}
