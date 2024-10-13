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
        logo-text = "C";
      };
      theme = {
        light = false;
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
                      links = [
                        { title = "Books"; url = "https://aayla3.bun-buri.ts.net/calibre/";}
                        { title = "Documents"; url = "https://aayla3.bun-buri.ts.net/paperless/accounts/login/?next=/paperless/";}
                        { title = "Passwords"; url = "https://aayla3.bun-buri.ts.net/vaultwarden/#/login";}
                        { title = "Photos"; url = "https://photos.ceeser.com/";}
                        { title = "Sync"; url = "http://127.0.0.1:8384/#";}
                      ];
                    }
                    {
                      title = "Finance";
                      color = "hsl(10 70% 50%)";
                      links = [
                        { title = "Carta"; url = "https://app.carta.com/accounts/login";}
                        { title = "Chase"; url = "https://secure.chase.com/web/auth/dashboard#/dashboard/index/index";}
                        { title = "EQ Bank"; url = "https://secure.eqbank.ca/login";}
                        { title = "Kraken"; url = "https://www.kraken.com/sign-in";}
                        { title = "N26"; url = "https://app.n26.com/login";}
                        { title = "Neo"; url = "https://member.neofinancial.com/login";}
                        { title = "Privacy"; url = "https://privacy.com/home";}
                        { title = "Robinhood"; url = "https://robinhood.com/us/en/";}
                        { title = "Splitwise"; url = "https://www.splitwise.com/";}
                        { title = "TD"; url = "https://www.td.com/ca/en/personal-banking/";}
                        { title = "WealthSimple"; url = "https://www.wealthsimple.com/en-ca/";}
                        { title = "Wise"; url = "https://wise.com/";}
                      ];
                    }
                    {
                      title = "Tech";
                      color = "hsl(200 50% 50%)";
                      links = [
                        { title = "Oracle Cloud"; url = "https://cloud.oracle.com";}
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
                { type = "hacker-news"; collapse-after = 30; }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "markets";
                  markets = [
                    { name = "S&P 500"; symbol = "SPY"; }
                    { name = "Apple"; symbol = "AAPL"; }
                    { name = "Google"; symbol = "GOOGL"; }
                    { name = "Nvidia"; symbol = "NVDA"; }
                    { name = "AMD"; symbol = "AMD"; }
                    { name = "Meta"; symbol = "META"; }
                  ];
                }
              ];
            }
          ];
          name = "Home";
        }
      ];
    };
  };
}
