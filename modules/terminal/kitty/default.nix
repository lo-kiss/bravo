{ 
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    theme = "One Dark"; # run `kitty +kitten themes` to see themes 

    settings = {
      mouse_hide_wait = 0;
      enable_audio_bell = false;
      wayland_titlebar_color = "system";
      confirm_os_window_close = 0;
    };

    keybindings = {
      "f1" = "launch --cwd=current";
      "f2" = "launch --cwd=current --type=tab";
    };
  };
}

