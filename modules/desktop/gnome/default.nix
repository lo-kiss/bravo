{ pkgs, ...}:
{
  home.packages = (with pkgs; [
    bibata-cursors
    fragments
    fractal
    metadata-cleaner
    blackbox-terminal
    curtail
    celluloid
    newsflash
    gnome-obfuscate
    video-trimmer
    gnome.gnome-tweaks
    amberol
    cartridges
    eyedropper
    mousai
    livecaptions
    impression
  ]) ++ (with pkgs.gnomeExtensions; [
    rounded-window-corners
    gsconnect
  ]);
}
