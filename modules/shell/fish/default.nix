{ pkgs, ...}:
{
  programs.fish = {
    enable = true;
    # shellAliases = { };
    shellAbbrs = {
      cl = "clear";
    };
  };

  home.packages = with pkgs; [
    fishPlugins.autopair
  ];
}

