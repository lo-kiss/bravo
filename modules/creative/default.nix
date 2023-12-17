{ pkgs, ...}:
{
  home.packages = (with pkgs; [
    krita
    blender
    inkscape
    godot_4
    # blockbench-electron # uses EOL electron
  ]);
}

