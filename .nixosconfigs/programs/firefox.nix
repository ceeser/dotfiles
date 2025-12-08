# Config for firefox

{ lib, config, pkgs, ... }:

  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in
{

  options.ceeser.programs.firefox = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures the firefox browser
      '';
    };
  };

  config = lib.mkIf config.ceeser.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [ "en-US" ];
      package = pkgs.firefox-esr;

      /* ---- POLICIES ---- */
      # Check about:policies#documentation for options.
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;

        Cookies = {
          Locked = true;
          Behavior = "reject-foreign";
        };

        DisableAccounts = true;
        DisableBuiltinPDFViewer = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisableMasterPasswordCreation = true;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableSecurityBypass = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "never"; # alternatives: "always", "never" or "default-on"

        DNSOverHTTPS = {
          Enabled = false;
          Locked = true;
        };

        DontCheckDefaultBrowser = true;
        DownloadDirectory = "~/Downloads";

        EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        /* ---- EXTENSIONS ---- */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below

          # Ublock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };

          # Clear Urls
          #"{74145f27-f039-47ce-a470-a662b129930a}" = {
          #  install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          #  installation_mode = "force_installed";
          #};

          # Decentraleyes
          "jid1-BoFifL9Vbdl2zQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
            installation_mode = "force_installed";
          };

          # Duck Duck Go Privacy Essentials
          "jid1-ZAdIEUB7XOzOJw@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-privacy-essentials/latest.xpi";
            installation_mode = "force_installed";
          };

          # Ghostery
          "firefox@ghostery.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi";
            installation_mode = "force_installed";
          };

          # Privacy Badger
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };

          # Skip Redirect
          "skipredirect@sblask" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
            installation_mode = "force_installed";
          };
        };

        ExtensionUpdate = true;

        FirefoxHome = {
          Search = false;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
          Locked = true;
        };

        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
          Locked = true;
        };

        HardwareAcceleration = true;

        Homepage = {
          URL = "https://luminara1.bun-buri.ts.net/home/";
          StartPage = "homepage-locked";
          Locked = true;
        };
        HttpsOnlyMode = "allowed";

        ManualAppUpdateOnly = true;

        NetworkPrediction = false;
        NewTabPage = false;
        NoDefaultBookmarks = true;

        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";

        PasswordManagerEnabled = false;
        PDFjs = {
          Enabled = false;
          EnablePermissions = false;
        };
        Permissions = {
          Camera = {
            Allow = [ "https://meet.jit.si/" ];
            BlockNewRequests = true;
          };
          Microphone = {
            Allow = [ "https://meet.jit.si/" ];
            BlockNewRequests = true;
          };
          Location = {
            BlockNewRequests = true;
            Locked = true;
          };
          Notifications = {
            BlockNewRequests = true;
            Locked = true;
          };
          Autoplay = {
            Default = "block-audio-video";
            Locked = true;
          };
          VirtualReality = {
            BlockNewRequests = true;
            Locked = true;
          };
        };
        PopupBlocking = {
          Default = true;
          Locked = true;
        };

        /* ---- PREFERENCES ---- */
        # Check about:config for options.
        Preferences = {
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          "browser.newtabpage.activity-stream.telemetry" = lock-false;
          "browser.ping-centre.telemetry" = lock-false;
          "datareporting.healthreport.service.enabled" = lock-false;
          "datareporting.healthreport.uploadEnabled" = lock-false;
          "datareporting.policy.dataSubmissionEnabled" = lock-false;
          "datareporting.sessions.current.clean" = lock-true;
          "devtools.onboarding.telemetry.logged" = lock-false;
          "toolkit.telemetry.archive.enabled" = lock-false;
          "toolkit.telemetry.bhrPing.enabled" = lock-false;
          "toolkit.telemetry.enabled" = lock-false;
          "toolkit.telemetry.firstShutdownPing.enabled" = lock-false;
          "toolkit.telemetry.hybridContent.enabled" = lock-false;
          "toolkit.telemetry.newProfilePing.enabled" = lock-false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = lock-true;
          "toolkit.telemetry.reportingpolicy.firstRun" = lock-false;
          "toolkit.telemetry.shutdownPingSender.enabled" = lock-false;
          "toolkit.telemetry.unified" = lock-false;
          "toolkit.telemetry.unifiedIsOptIn" = lock-false;
          "toolkit.telemetry.updatePing.enabled" = lock-false;
        };
        PrimaryPassword = false;
        PrivateBrowsingModeAvailability = 1;
        PromptForDownloadLocation = false;
        SanitizeOnShutdown = {
          Cache = true;
          Cookies = true;
          FormData = true;
          History = true;
          Sessions = true;
          SiteSettings = true;
          Locked = true;
        };
        SearchBar = "unified"; # alternative: "separate"
        SearchEngines = {
          Add = [
            {
              Name = "DuckDuckGoCeeser";
              URLTemplate = "https://duckduckgo.com?q={searchTerms}&kp=-2&kz=-1&kav=1&kac=-1&kae=d&kn=1&k1=-1&kk=-1&kaj=m&kat=-1&kay=b&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kg=p&kbe=0&kbg=-1";
            }
          ];
          Default = "DuckDuckGoCeeser";
          PreventInstalls = true;
          Remove = [
            "DuckDuckGo"
            "Bing"
            "Google"
            "Wikipedia (en)"
          ];
        };
        SearchSuggestEnabled = false;
        ShowHomeButton = false;
        SkipTermsOfUse = true;
        SSLVersionMin = "tls1.2";
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          FirefoxLabs = false;
          Locked = true;
        };
      };
    };
  };
}
