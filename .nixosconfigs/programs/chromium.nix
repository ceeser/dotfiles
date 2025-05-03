# Config for chromium

{ config, pkgs, ... }:

{
  programs = {
    chromium = {
      enable = true;

      extraOpts = {
        AccessibilityShortcutsEnabled = false;
        AlwaysOpenPdfExternally = true;
        AssistantWebEnabled = false;
        AutoplayAllowed = false;

        BackgroundModeEnabled = false;
        BlockExternalExtensions = true;
        BlockThirdPartyCookies = true;
        BrowserLabsEnabled = false;
        BrowserSignin = 0;

        CalendarIntegrationEnabled = false;
        ClearBrowsingDataOnExitList = [
          "browsing_history"
          "download_history"
          "cookies_and_other_site_data"
          "cached_images_and_files"
          "password_signin"
          "autofill"
          "site_settings"
          "hosted_app_data"
        ];

        CloudProfileReportingEnabled = false;
        CloudReportingEnabled = false;

        DefaultBrowserSettingEnabled = false;
        DefaultClipboardSetting = 2;
        DefaultControlledFrameSetting = 2;
        DefaultCookiesSetting = 2;
        DefaultDirectSocketsSetting = 2;
        DefaultGeolocationSetting = 2;
        DefaultLocalFontsSetting = 2;
        DefaultNotificationsSetting = 2;
        DefaultPluginsSetting = 2;
        DefaultPopupsSetting = 2;
        DefaultSearchProviderEnabled = true;
        DefaultSearchProviderName = "DuckDuckGoCeeser";
        DefaultSearchProviderSearchURL = "https://duckduckgo.com?q={searchTerms}&kp=-2&kz=-1&kav=1&kac=-1&kae=d&kn=1&k1=-1&kk=-1&kaj=m&kat=-1&kay=b&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kg=p&kbe=0&kbg=-1";
        DefaultSensorsSetting = 2;
        DefaultSerialGuardSetting = 2;
        DefaultThirdPartyStoragePartitioningSetting = 2;
        DefaultWebBluetoothGuardSetting = 2;
        DefaultWebHidGuardSetting = 2;
        DefaultWebUsbGuardSetting = 2;
        DefaultWindowManagementSetting = 2;
        DefaultWindowPlacementSetting = 2;
        DeskAPIThirdPartyAccessEnabled = false;

        DeveloperToolsAvailability = 1;

        DeviceActivityHeartbeatEnabled = false;
        DeviceExtensionsSystemLogEnabled = false;
        DeviceFlexHwDataForProductImprovementEnabled = false;
        DeviceMetricsReportingEnabled = false;
        DeviceReportNetworkEvents = false;
        DeviceReportRuntimeCounters = false;
        DeviceReportXDREvents = false;

        DownloadDirectory = "~/Downloads";

        DriveDisabled = true;

        EnableDeviceGranularReporting = false;
        
        HeartbeatEnabled = false;
        HeartbeatFrequency = false;

        HomepageLocation = "https://luminara1.bun-buri.ts.net/home/";

        IncognitoEnabled = true;
        IncognitoModeAvailability = true;

        LogUploadEnabled = false;

        PasswordManagerEnabled = false;

        PrivacySandboxAdMeasurementEnabled = false;
        PrivacySandboxAdTopicsEnabled = false;
        PrivacySandboxPromptEnabled = false;
        PrivacySandboxSiteEnabledAdsEnabled = false;

        ReportAppInventory = false;
        ReportAppUsage = false;
        ReportArcStatusEnabled = false;
        ReportCRDSessions = false;
        ReportDeviceActivityTimes = false;
        ReportDeviceAppInfo = false;
        ReportDeviceAudioStatus = false;
        ReportDeviceBacklightInfo = false;
        ReportDeviceBluetoothInfo = false;
        ReportDeviceBoardStatus = false;
        ReportDeviceBootMode = false;
        ReportDeviceCpuInfo = false;
        ReportDeviceCrashReportInfo = false;
        ReportDeviceFanInfo = false;
        ReportDeviceGraphicsStatus = false;
        ReportDeviceHardwareStatus = false;
        ReportDeviceLoginLogout = false;
        ReportDeviceMemoryInfo = false;
        ReportDeviceNetworkConfiguration = false;
        ReportDeviceNetworkInterfaces = false;
        ReportDeviceNetworkStatus = false;
        ReportDeviceOsUpdateStatus = false;
        ReportDevicePeripherals = false;
        ReportDevicePowerStatus = false;
        ReportDevicePrintJobs = false;
        ReportDeviceSecurityStatus = false;
        ReportDeviceSessionStatus = false;
        ReportDeviceStorageStatus = false;
        ReportDeviceSystemInfo = false;
        ReportDeviceTimezoneInfo = false;
        ReportDeviceUsers = false;
        ReportDeviceVersionInfo = false;
        ReportDeviceVpdInfo = false;
        ReportUploadFrequency = false;
        ReportWebsiteActivityAllowlist = false;
        ReportWebsiteTelemetry = false;

        RestoreOnStartup = 1;

        ScreenCaptureAllowed = false;
        ShowHomeButton = false;
        SpellcheckEnabled = false;
        SyncDisabled = true;
        SystemUse24HourClock = true;

        TabFreezingEnabled = true;
      };

      extensions = [
      #  "ddkjiahejlhfcafbddmgiahcphecmpfh"  # ublock origin lite
      #  "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"  # privacy badger
      #  "jaoafjdoijdconemdmodhbfpianehlon"  # skip redirect
      #  "ldpochfccmkkmhdbclfhpagapcfdljkj"  # decentraleyes
      #  "mlomiejdfkolichcflejclcbmpeaniij"  # ghostery
      #  "lckanjgmijmafbedllaakclkaicjfmnk"  # clear urls
      #  "bkdgflcldnnnapblkhphbgpggdiikppg"  # Duck duck go privacy essentials
      ];
    };
  };
}
