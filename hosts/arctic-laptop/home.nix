{ ... }:

{
  imports = [
    ../../modules/home
  ];

  # This is home-manager modules. So it will be enabled only for user environment.
  modules = {
    # Enable zsh.
    zsh.enable = true;

    # Enable fastfetch, otherwise how can you tell "I'm using Nix btw".
    # You can check configuration in fastfetch.nix.
    fastfetch.enable = true;

    # Enable neovim. This can be changed in future.
    neovim.enable = true;
  };

  # Do not touch.
  home.stateVersion = "25.05"; # Please read the comment before changing.
}
