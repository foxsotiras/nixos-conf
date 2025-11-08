# Default NixOS options.
{ lib, inputs, ... }:

{
  # Install and setup grub for UEFI system.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
    grub = {
      configurationName = "NixOS Boot Manager";
      device = "nodev";
      efiSupport = true;
      memtest86.enable = true;
    };
  };

  # Set timezone.
  time.timeZone = "Europe/Moscow";

  # Set locale settings.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [
      "nb_NO.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
      "sv_SE.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_CTYPE = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_TIME = "nb_NO.UTF-8";
      LC_COLLATE = "nb_NO.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
    };
  };

  # Enable NetworkManager.
  networking.networkmanager.enable = true;

  # Change iptables to nftables.
  # TODO: check for Docker update.
  # networking.nftables.enable = true;

  # Change sudo settings.
  security.sudo = {
    execWheelOnly = true;
    extraConfig = lib.concatStringsSep "\n" [
      "Defaults timestamp_timeout=30"
      "Defaults timestamp_type=global"
      "Defaults passwd_timeout=0"
    ];
  };

  # Install hardware for graphics.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  # Setup git system-wide.
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "master";
    };
  };

  # NixOS settings.
  nix = {
    # Enable automatic garbage collection.
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
    # Enable flakes and automatic optimization of storage.
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command"  "flakes" ];
    };
  };

  # Enable automatic system upgrades.
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flags = [
      "--print-build-logs"
    ];
    flake = inputs.self.outPath;
  };
}
