{
  programs.firefox = {
    enable = true;
    policies = {
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      PromptForDownloadLocation = true;
      OfferToSaveLogins = false;
      AppAutoUpdate = false;
      CaptivePortal = false;

      SearchEngines = {
        Default = "DuckDuckGo";
        Remove = [
          "Google" 
          "Amazon.com"
          "Bing"
        ];
      };

      ExtensionUpdate = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          "installation_mode" = "force_installed";
          "install_url" = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };

      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      Cookies.Behavior = "reject-foreign";

      WebsiteFilter.Block = [
        "https://www.4chan.org/"
        "https://www.4channel.org/"
      ];

      Permissions = {
        Autoplay.Default = "block-audio-video";
      };

      PopupBlocking = {
        Default = true;
      };

      NewTabPage = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = false;
        Pocket = false;
        SponsoredPocket = false;
      };

      UserMessaging = {
        SkipOnboarding = true;
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        MoreFromMozilla = false;
      };

      nativeMessagingHosts.gsconnect = true;
    };
  };
}
