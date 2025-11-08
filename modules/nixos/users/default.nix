{ pkgs, ... }:

{
  # Install zsh system-wide.
  programs.zsh.enable = true;

  # Define a default user account.
  users.users.johnny = {
    isNormalUser = true;
    description = "Johnny Fox";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh; # Choose your preferred shell.
  };
}
