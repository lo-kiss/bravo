{ inputs, lib, config, pkgs, ...}:
{
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
    gnomeExtensions.blur-my-shell
    gnomeExtensions.pano
    gnomeExtensions.pop-shell
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.gsconnect

    # lang servers
    lua-language-server
    vscode-langservers-extracted
    marksman # for markdown
    nil # for nix
    # libclang # for C/C++
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

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "onedark";
      editor = {
        auto-format = false;
        line-number = "relative";
        bufferline = "multiple";
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        whitespace.render.tab = "all";
        indent-guides = {
          render = true;
          character = "▏";
          skip-levels = 1;
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };

      keys.normal = {
        C-s = ":w";
      };
      keys.insert = {
        j.j = "normal_mode";
      };
    };
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
