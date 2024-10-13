# Config for glance dashbaord

{ config, pkgs, ... }:

{
  services.glance = {
    enable = true;
    settings = {
      #base-url = "/home";
      server.host = "0.0.0.0";
      server.port = 38295;
      branding = {
        hide-footer = true;
      };
      theme = {
        background-color = "hsl(240, 21%, 15%)";
        contrast-multiplier = 1.2;
        primary-color = "hsl(217 92% 83%)";
        positive-color = "hsl(115 54% 76%)";
        negative-color = "hsl(347 70% 65%)";
      };
      pages = [
        {
          columns = [
            {
              size = "small";
              widgets = [
                { type = "calendar"; }
                {
                  type = "bookmarks";
                  groups = [
                    {
                      title = "Homelab";
                      color = "hsl(10 70% 50%)";
                      links = [
                        { title = "Books"; url = "https://aayla3.bun-buri.ts.net/calibre/";}
                        { title = "Documents"; url = "https://aayla3.bun-buri.ts.net/paperless/accounts/login/?next=/paperless/";}
                        { title = "Passwords"; url = "https://aayla3.bun-buri.ts.net/vaultwarden/#/login";}
                        { title = "Photos"; url = "https://photos.ceeser.com/";}
                        { title = "Sync"; url = "http://127.0.0.1:8384/#";}
                      ];
                    }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "rss";
                  style = "horizontal-cards";
                  limit = 20;
                  feeds = [
                    { title = "The Grumpy Economist"; url = "https://www.grumpy-economist.com/feed"; }
                    { title = "Julia Evans"; url = "https://jvns.ca/atom.xml"; }
                  ];
                }
                { type = "hacker-news"; }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "markets";
                  markets = [
                    { name = "S&P 500"; symbol = "SPY"; }
                  ];
                }
              ];
            }
          ];
          name = "Calendar";
        }
      ];
    };
  };
}
