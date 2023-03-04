{ config, lib, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs28NativeComp;
  };

  home.packages = with pkgs; [
    cmake
    editorconfig-core-c
    discount
    gnugrep
    gopls
    gotests
    gomodifytags
    gore
    graphviz
    imagemagick
    shellcheck
  ];

  home.file = {
    ".doom.d/config.el".source = ./doom/config.el;
    ".doom.d/init.el".source = ./doom/init.el;
    ".doom.d/packages.el".source = ./doom/packages.el;

    # doomemacs checks for gls on a mac.
    "bin/gls" = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      executable = true;
      text = ''
        #!/usr/bin/env zsh
        ${pkgs.coreutils}/bin/ls "$@"
      '';
    };
  };
}
