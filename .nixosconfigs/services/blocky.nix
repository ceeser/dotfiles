# Config for blocky

{ config, pkgs, ... }:

{
  services.blocky = {
    enable = true;
    settings = {
      ports.dns = 53; # Port for incoming DNS Queries.
      upstreams.groups.default = [ # You can define as many upstream groups as you want.
        "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
      ];
      # For initially solving DoH/DoT Requests when no system Resolver is available.
      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = [ "1.1.1.1" "1.0.0.1" ];
      };

      #Enable Blocking of certain domains.
      blocking = {
        allowlists = {
          all = ["*.gmail.com"];
        };
        denylists = {
          all = [
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://someonewhocares.org/hosts/zero/hosts"
            "https://v.firebog.net/hosts/Easyprivacy.txt"
            "https://v.firebog.net/hosts/Prigent-Ads.txt"
            "https://zerodot1.gitlab.io/CoinBlockerLists/hosts"
            "https://adaway.org/hosts.txt"
            "https://v.firebog.net/hosts/AdguardDNS.txt"
            "https://v.firebog.net/hosts/Easylist.txt"
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat"
            "https://v.firebog.net/hosts/Prigent-Malware.txt"
            "https://phishing.army/download/phishing_army_blocklist_extended.txt"
            "https://www.stopforumspam.com/downloads/toxic_domains_whole.txt"
            "https://v.firebog.net/hosts/Admiral.txt"
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat"
            "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
            "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
            "https://v.firebog.net/hosts/Prigent-Crypto.txt"
            "https://urlhaus.abuse.ch/downloads/hostfile/"
            "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
            "https://jasonhill.co.uk/pfsense/ytadblock.txt"
            "https://www.encrypt-the-planet.com/downloads/hosts"
            "https://perflyst.github.io/PiHoleBlocklist/SmartTV.txt"
            # blocky formatted lists
            "https://raw.githubusercontent.com/Turtlecute34/toolz/master/src/d3host.txt"
            "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/ultimate.txt"
          ];
        };
        #Configure what block categories are used
        clientGroupsBlock = {
          default = [ "all" ];
        };
      };
    };
  };
  
  # disable resolved, so that blocky can service port 53
  services.resolved.enable = false;
}
