{ pkgs, ...}:
{
  home.packages = (with pkgs; [
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
    mission-center
    cartridges
    eyedropper
    mousai
    livecaptions
  ]) ++ (with pkgs.gnomeExtensions; [
    rounded-window-corners
    pano
    gsconnect
    burn-my-windows
  ]);
}
