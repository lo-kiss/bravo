{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
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
    packages = with pkgs; [
      gh
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # terminal
    curl
    git
    fish

    # gui
    librewolf
    # inkscape # Out of date, won't be updated until 1.3.1. Installed from flatpak in the mean time
    minetest
    krita
    blender
    godot_4
    # pixelorama
    blackbox-terminal

    # gnome
    curtail
    celluloid
    newsflash
    gnome-obfuscate
    video-trimmer
    gnome.gnome-tweaks
    amberol
  ];

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

  # List services that you want to enable:
  zramSwap.enable = true;
  services = {
    flatpak.enable = true;
    printing.enable = true; # Enable CUPS to print documents.
    # openssh.enable = true; # Enable the OpenSSH daemon.
  };

  programs.firefox = {
    enable = true;
    policies = {
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      PromptForDownloadLocation = true;
      OfferToSaveLogins = false;
      AppAutoUpdate = false;
      CaptivePortal = false;

      SearchEngines = {
        Default = "DuckDuckGo";
        Remove = [
          "Google" 
          "Amazon.com"
          "Bing"
        ];
      };

      ExtensionUpdate = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          "installation_mode" = "force_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      Cookies.Behavior = "reject-foreign";

      WebsiteFilter.Block = [
        "https://www.4chan.org/"
        "https://www.4channel.org/"
      ];

      Permissions = {
        Autoplay.Default = "block-audio-video";
      };

      PopupBlocking = {
        Default = true;
      };

      NewTabPage = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Pocket = false;
        SponsoredPocket = false;
      };

      UserMessaging = {
        SkipOnboarding = true;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        MoreFromMozilla = false;
      };

      nativeMessagingHosts.gsconnect = true;
    };
  };
 
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}