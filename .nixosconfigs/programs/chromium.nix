# Config for chromium

{ config, pkgs, ... }:

{
  programs = {
    chromium = {
      enable = true;

      extraOpts = {
        AssistantWebEnabled = false;

        BlockExternalExtensions = true;
        BrowserSignin = 0;

        CalendarIntegrationEnabled = false;
        CloudProfileReportingEnabled = false;
        CloudReportingEnabled = false;

        DefaultClipboardSetting = 2;
        DefaultControlledFrameSetting = 2;
        DefaultCookiesSetting = 2;
        DefaultDirectSocketsSetting = 2;
        DefaultGeolocationSetting = 2;
        DefaultLocalFontsSetting = 2;
        DefaultMediaStreamSetting = 3;
        DefaultNotificationsSetting = 2;
        DefaultPluginsSetting = 2;
        DefaultPopupsSetting = 2;
        DefaultSearchProviderEnabled = true;
        DefaultSearchProviderName = "DuckDuckGoCeeser";
        DefaultSearchProviderSearchURL = "https://duckduckgo.com?q=%s&kp=-2&kz=-1&kav=1&kac=-1&kae=d&kn=1&k1=-1&kk=-1&kaj=m&kat=-1&kay=b&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kg=p&kbe=0&kbg=-1";
        DefaultSensorsSetting = 2;
        DefaultSerialGuardSetting = 2;
        DefaultThirdPartyStoragePartitioningSetting = 2;
        DefaultWebBluetoothGuardSetting = 2;
        DefaultWebHidGuardSetting = 2;
        DefaultWebUsbGuardSetting = 2;
        DefaultWindowManagementSetting = 2;
        DefaultWindowPlacementSetting = 2;
        DeskAPIThirdPartyAccessEnabled = false;
        DriveDisabled = true;
        

        PasswordManagerEnabled = false;

        ScreenCaptureAllowed = false;
        SpellcheckEnabled = false;
        SyncDisabled = true;
        SystemUse24HourClock = true;
      };

      extensions = [];
      homepageLocation = "";
    };
  };
}
