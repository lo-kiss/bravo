{ pkgs, ...}:
{
  home.packages = with pkgs; [
    bibata-cursors
    fragments
    metadata-cleaner
    blackbox-terminal
    curtail
    celluloid
    newsflash
    gnome-obfuscate
    video-trimmer
    gnome.gnome-tweaks
    amberol
  
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.just-perfection
    gnomeExtensions.pano
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.gsconnect
    gnomeExtensions.burn-my-windows
  ];
}
