{ config, lib,  pkgs, ... }:

with lib;
let
  cfg = config.networking;
  net = config.modules.networking;

in
{
  # This option only for perfection xD.
  # I don't like default /etc/hosts configuration in NixOS so I've oversritten it.
  options.modules.networking = {
    patches.enable = mkEnableOption "Enable /etc/hosts changes";
  };

  config = mkIf net.patches.enable (mkForce {
    networking.hosts =
      let
        hostnames = optional (cfg.hostName != "" && cfg.domain != null) "${cfg.hostName}.${cfg.domain}"
          ++ optional (cfg.hostName != "") cfg.hostName;
      in
        {
          "127.0.1.1" = hostnames;
        };

    networking.hostFiles =
      let
        localhostHosts = pkgs.writeText "localhost-hosts" ''
          127.0.0.1 localhost
          ${optionalString cfg.enableIPv6 concatStringsSep "\n" [
            "::1 localhost"
            "ff02::1 ip6-allnodes"
            "ff02::2 ip6-allrouters"
          ]}
        '';
        stringHosts =
          let
            oneToString = set: ip: ip + " " + concatStringsSep " " set.${ip} + "\n";
            allToString = set: concatMapStrings (oneToString set) (attrNames set);
          in
            pkgs.writeText "string-hosts" (allToString (filterAttrs (_: v: v != [ ]) cfg.hosts));
        extraHosts = pkgs.writeText "extra-hosts" cfg.extraHosts;
      in
        mkBefore [
          localhostHosts
          stringHosts
          extraHosts
        ];
  });
}
