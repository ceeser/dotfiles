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
}
