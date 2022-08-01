{ lib, pkgs, ... }: {
  programs.gpg = {
    enable = true;
    settings = if pkgs.stdenv.isLinux then {
      "pinentry-mode" = "loopback";
    } else {
      no-tty = true;
    };
  };

  services.gpg-agent = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    enable = true;
    defaultCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    maxCacheTtl = 1036800;
    maxCacheTtlSsh = 1036800;

    extraConfig = ''
      allow-loopback-pinentry
      allow-preset-passphrase
    '';
  };

  home.file = {
    ".gnupg/dirmngr.conf".text = ''
      keyserver hkps://keys.openpgp.org
    '';

    ".gnupg/gpg-agent.conf" = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      text = ''
        default-cache-ttl 86400
        default-cache-ttl-ssh 86400
        max-cache-ttl 1036800
        max-cache-ttl-ssh 1036800
        pinentry-program /usr/local/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS/pinentry-mac
      '';
    };
  };
}
