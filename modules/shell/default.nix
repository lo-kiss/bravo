{ pkgs, ...}:
{
  # Applies to all shells (aliases must have contents that work on all shells)
  home.shellAliases = {
    "..." = "cd ../..";
    cat = "bat";
    mv = "mv -i";
    cp = "cp -i";
    rm = "rm -I";
    mkdir = "mkdir -p";
    ls-gen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
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

  home.packages = with pkgs; [
    bat
    tldr
    neofetch
    trashy
  ];
}

