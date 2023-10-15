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
  ];

  fonts.fonts = with pkgs; [
    ( nerdfonts.override { 
      fonts = [ 
        "Iosevka"
        "IosevkaTerm"
       ]; 
    })
  ];

  fonts.fontconfig.defaultFonts.sansSerif = ["Cantarell Regular"];
  fonts.fontconfig.defaultFonts.monospace = ["IosevkaTerm Nerd Font Mono SemiBold"];

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
