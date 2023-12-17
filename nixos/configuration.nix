{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../modules/security/default.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      loki = import ../home-manager/home.nix;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.memtest86.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "nixussy";
    networkmanager.enable = true;
    firewall.enable = false;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ 1714 1764 ];
    # firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    wacom.enable = true;
    digimend.enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };

  services.gnome.gnome-browser-connector.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.loki = {
    isNormalUser = true;
    description = "loki";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-console # alternative: blackbox
    gnome-photos # alternative: the default image viewer or opening the file manager
    gnome-tour
    # gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    epiphany # gnome web - install from flatpak
    gnome-system-monitor # alternative: mission center
    totem # alternative: celluloid
    gnome-music # alternative: amberol
  ]);

  environment.systemPackages = with pkgs; [
    git
    minetest
  ];

  fonts.packages = with pkgs; [
    ( nerdfonts.override { 
      fonts = [ 
        "Iosevka"
        "IosevkaTerm"
       ]; 
    })
  ];

  fonts.fontconfig.defaultFonts.sansSerif = ["Cantarell Regular"];
  fonts.fontconfig.defaultFonts.monospace = ["IosevkaTerm Nerd Font Mono SemiBold"];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  zramSwap.enable = true;
  services = {
    flatpak.enable = true;
    printing.enable = true; # Enable CUPS to print documents.
    # openssh.enable = true; # Enable the OpenSSH daemon.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
