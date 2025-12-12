# Config for glance dashbaord

{ lib, config, pkgs, ... }:

{
  options.ceeser.services.glance = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Installs and configures the glance dashboard service
      '';
    };
  };
  config = lib.mkIf config.ceeser.services.glance.enable {
    services.glance = {
      enable = true;
      settings = {
        server = {
          base-url = "/home";
          host = "0.0.0.0";
          port = 38295;
        };
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
            name = "Home";
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "monitor";
                    title = "Services";
                    sites = [
                      { title = "Bookmarks"; url = "https://aayla3.bun-buri.ts.net/readeck/";}
                      { title = "Books"; url = "https://aayla3.bun-buri.ts.net/calibre/";}
                      { title = "Code"; url = "https://aayla3.bun-buri.ts.net/code/";}
                      { title = "Documents"; url = "https://aayla3.bun-buri.ts.net/paperless/accounts/login/?next=/paperless/";}
                      { title = "Passwords"; url = "https://aayla3.bun-buri.ts.net/vaultwarden/#/login";}
                      { title = "Photos"; url = "https://photos.ceeser.com/";}
                      { title = "Sync"; url = "http://127.0.0.1:8384/#";}
                    ];
                  }
                  {
                    type = "bookmarks";
                    groups = [
                      {
                        title = "Finance";
                        color = "hsl(10 70% 50%)";
                        links = [
                          { title = "Carta"; url = "https://app.carta.com/accounts/login";}
                          { title = "Chase"; url = "https://secure.chase.com/web/auth/dashboard#/dashboard/index/index";}
                          { title = "EQ Bank"; url = "https://secure.eqbank.ca/login";}
                          { title = "Kraken"; url = "https://www.kraken.com/sign-in";}
                          { title = "N26"; url = "https://app.n26.com/login";}
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
                          { title = "Cloudflare"; url = "https://www.cloudflare.com";}
                          { title = "Oracle Cloud"; url = "https://cloud.oracle.com";}
                        ];
                      }
                    ];
                  }
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
              {
                size = "full";
                widgets = [
                  {
                    type = "search";
                    search-engine = "duckduckgo";
                    autofocus = true;
                    new-tab = true;
                  }
                  {
                    type = "group";
                    widgets = [
                      { type = "hacker-news"; limit = 30; collapse-after = -1; }
                      { type = "lobsters"; limit = 30; collapse-after = -1; }
                      {
                        type = "rss";
                        title = "Hackaday";
                        style = "vertical-list";
                        limit = 30;
                        collapse-after = -1;
                        feeds = [
                          { title = "Hackaday"; url = "https://hackaday.com/blog/feed/"; }
                        ];
                      }
                      {
                        type = "rss";
                        title = "Other";
                        style = "vertical-list";
                        limit = 30;
                        collapse-after = -1;
                        feeds = [
                          { title = "Simon Willison"; url = "https://simonwillison.net/atom/everything/"; }
                          { title = "Martin Kleppmann"; url = "https://feeds.feedburner.com/martinkl"; }
                          { title = "The Grumpy Economist"; url = "https://www.grumpy-economist.com/feed"; }
                          { title = "Wealthsimple Product News"; url = "https://product-news.wealthsimple.com/feed"; }
                          { title = "System76 Blog"; url = "https://blog.system76.com/rss"; }
                          { title = "Julia Evans"; url = "https://jvns.ca/atom.xml"; }
                        ];
                      }
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  { type = "calendar"; }
                  {
                    type = "clock";
                    hour-format = "24h";
                    timezones = [
                      { label = "San Francisco"; timezone = "America/Los_Angeles"; }
                      { label = "New York"; timezone = "America/New_York"; }
                      { label = "London"; timezone = "Europe/London"; }
                      { label = "Melbourne"; timezone = "Australia/Melbourne"; }
                    ];
                  }
                ];
              }
            ];
          }
          {
            name = "Markets";
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "markets";
                    title = "Indices";
                    markets = [
                      { symbol = "SPY"; name = "S&P 500";}
                      { symbol = "DX-Y.NYB"; name = "Dollar Index";}
                    ];
                  }
                  {
                    type = "markets";
                    title = "Crypto";
                    markets = [
                      { symbol = "BTC-USD"; name = "Bitcoin";}
                      { symbol = "ETH-USD"; name = "Ethereum";}
                    ];
                  }
                  {
                    type = "markets";
                    title = "Stocks";
                    sort-by = "absolute-change";
                    markets = [
                      { name = "AMD"; symbol = "AMD"; }
                      { name = "Amazon"; symbol = "AMZN"; }
                      { name = "Apple"; symbol = "AAPL"; }
                      { name = "Google"; symbol = "GOOGL"; }
                      { name = "Meta"; symbol = "META"; }
                      { name = "Microsoft"; symbol = "MSFT"; }
                      { name = "Nvidia"; symbol = "NVDA"; }
                      { name = "Tesla"; symbol = "TSLA"; }
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "rss";
                    title = "News";
                    style = "horizontal-cards";
                    feeds = [
                      { title = "Bloomberg"; url = "https://feeds.bloomberg.com/markets/news.rss"; }
                      { title = "Fox Business"; url = "https://moxie.foxbusiness.com/google-publisher/markets.xml"; }
                      { title = "Fox Business"; url = "https://moxie.foxbusiness.com/google-publisher/technology.xml"; }
                    ];
                  }
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "reddit";
                        show-thumbnails = true;
                        subreddit = "technology";
                      }
                      {
                        type = "reddit";
                        show-thumbnails = true;
                        subreddit = "wallstreetbets";
                      }
                    ];
                  }
                  {
                    type = "videos";
                    style = "grid-cards";
                    collapse-after-rows = 3;
                    channels = [
                      "UCvSXMi2LebwJEM1s4bz5IBA" # New Money
                      "UCV6KDgJskWaEckne5aPA0aQ" # Graham Stephan
                      "UCAzhpt9DmG6PnHXjmJTvRGQ" # Federal Reserve
                    ];
                  }
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "rss";
                    title = "News";
                    limit = 30;
                    collapse-after = 13;
                    feeds = [
                      { title = "Financial Times"; url = "https://www.ft.com/technology?format=rss"; }
                      { title = "Fox Business"; url = "https://feeds.a.dj.com/rss/RSSMarketsMain.xml"; }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
