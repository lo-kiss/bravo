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
    celestia

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

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}
