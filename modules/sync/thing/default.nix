{
  services = {
    syncthing = {
      enable = true;
      user = "loki";
      dataDir = "/home/loki/Documents";
      configDir = "/home/loki/.config/syncthing";
      overrideDevices = true; # overrides any devices added or deleted through the WebUI
      overrideFolders = true; # overrides any folders added or deleted through the WebUI
      # devices = {
      #   "sam" = { id = "DEVICE-ID-GOES-HERE"; };
      # };
      # folders = {
      #   "University" = { # Name of folder in Syncthing, also the folder ID
      #     path = "/home/loki/Documents/University/"; # Which folder to add to Syncthing
      #     devices = [ "sam" ]; # Which devices to share the folder with
      #   };
      # };
    };
  };
}

