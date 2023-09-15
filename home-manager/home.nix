{ inputs, lib, config, pkgs, ...}:
{
  imports = [
    ../modules/editors/helix/default.nix
  ];

  home.username = "loki";
  home.homeDirectory = "/home/loki";

  home.packages = with pkgs; [
    bat
    tldr
    neofetch
    bibata-cursors
    fragments
    metadata-cleaner
    prismlauncher
    ( nerdfonts.override { fonts = [ "Iosevka" ]; })
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.just-perfection
    gnomeExtensions.pano
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.gsconnect
    gnomeExtensions.burn-my-windows
  ];

  programs.git = {
    enable = true;
    userName = "lo-kiss";
    userEmail = "115636509+lo-kiss@users.noreply.github.com";
    delta.enable = true;
  };

  programs.gitui.enable = true;

  # Applies to all shells (aliases should have contents that work on all shells)
  home.shellAliases = {
    "..." = "cd ../..";
    cat = "bat";
    ls-gen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
  };

  programs.fish = {
    enable = true;
    # shellAliases = { };
    shellAbbrs = {
      cl = "clear";
    };
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
      "--no-user"
    ];
  };

  # programs.kitty = {
  #   enable = true;
  #   shellIntegration.enableFishIntegration = true;
  #   theme = "One Dark"; # run `kitty +kitten themes` to see themes 

  #   settings = {
  #     mouse_hide_wait = 0;
  #     enable_audio_bell = false;
  #     wayland_titlebar_color = "system";
  #     confirm_os_window_close = 0;
  #   };

  #   keybindings = {
  #     "f1" = "launch --cwd=current";
  #     "f2" = "launch --cwd=current --type=tab";
  #   };
  # };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
