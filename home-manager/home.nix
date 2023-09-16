{ inputs, lib, config, pkgs, ...}:
{
  imports = [
    ../modules/editors/helix/default.nix
    ../modules/shell/default.nix
    ../modules/shell/fish/default.nix
    ../modules/desktop/gnome/default.nix
  ];

  home.username = "loki";
  home.homeDirectory = "/home/loki";

  home.packages = with pkgs; [
    prismlauncher
    ( nerdfonts.override { 
      fonts = [ 
        "Iosevka"
        "IosevkaTerm"
       ]; 
    })
  ];

  programs.git = {
    enable = true;
    userName = "lo-kiss";
    userEmail = "115636509+lo-kiss@users.noreply.github.com";
    delta.enable = true;
  };

  programs.gitui.enable = true;

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
