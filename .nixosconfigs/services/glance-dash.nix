# Config for glance dashbaord

{ config, pkgs, ... }:

{
  services.glance = {
    enable = true;
    settings = {
      #base-url = "/home";
      server.host = "0.0.0.0";
      server.port = 38295;
      pages = [
        {
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "calendar";
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
