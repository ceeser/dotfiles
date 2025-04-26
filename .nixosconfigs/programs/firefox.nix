# Config for firefox

{ config, pkgs, ... }:

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
  programs = {
    firefox = {
      enable = true;
      languagePacks = [ "en-US" ];

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
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"

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
          # Bitwarden password manager
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
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

        Homepage = {
          URL = "https://luminara1.bun-buri.ts.net/home/";
          StartPage = "homepage-locked";
          Locked = true;
        };
        HttpsOnlyMode = "force_enabled";

        NewTabPage = false;
        NoDefaultBookmarks = true;

        OfferToSaveLogins = false;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";

        PasswordManagerEnabled = false;

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
        PromptForDownloadLocation = false;
        SanitizeOnShutdown = true;
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
          #Remove = [ "" ];
        };
        SearchSuggestEnabled = false;
        ShowHomeButton = false;
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
