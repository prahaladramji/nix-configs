{ lib, pkgs, ... }: {
  imports = [ ./emacs ./git.nix ./gpg.nix ./ssh.nix ./tmux ./vscode.nix ./zsh ];

  home.packages = with pkgs;
    [
      argocd
      awscli2
      bazel_5
      coreutils
      cue
      curl
      discord
      unstable.docker-compose
      fd
      gh
      gnumake
      go-jsonnet
      google-cloud-sdk
      grpcurl
      htop
      kubernetes-helm
      jq
      k9s
      kind
      kubecfg
      kubectl
      kubectx
      lego
      moreutils
      nixfmt
      pipenv
      pre-commit
      protobuf
      (python310.withPackages (p: with p; [ pre-commit-hooks requests ]))
      (ripgrep.override { withPCRE2 = true; })
      rsync
      source-code-pro
      ssm-session-manager-plugin
      unstable.step-cli
      stow
      unstable.terraform
      terraform-docs
      tree
      vault
      wget
      whois
      yq-go
    ] ++ lib.optionals stdenv.isLinux [
      bc
      dig
      unstable.open-policy-agent
      signal-desktop
      sublime-merge
    ];

  programs = {
    alacritty = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      enable = true;

      # Config reference https://github.com/alacritty/alacritty/blob/master/alacritty.yml
      settings = {
        window = {
          padding.x = 12;
          padding.y = 6;
        };
        font = {
          size = 12.0;
          normal.family = "Source Code Pro";
          bold.family = "Source Code Pro";
          italic.family = "Source Code Pro";
          bold_italic.family = "Source Code Pro";
        };
        colors = {
          primary = {
            background = "0x282c34";
            foreground = "0xbbc2cf";
          };
          normal = {
            black = "0x282c34";
            red = "0xff6c6b";
            green = "0x98be65";
            yellow = "0xecbe7b";
            blue = "0x51afef";
            magenta = "0xc678dd";
            cyan = "0x46d9ff";
            white = "0xbbc2cf";
          };
        };
        key_bindings = [
          {
            key = "Right";
            mods = "Alt";
            chars = "\\x1BF";
          }
          {
            key = "Left";
            mods = "Alt";
            chars = "\\x1BB";
          }
        ];
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global = { load_dotenv = false; };
        whitelist = { prefix = [ "/home" "/Users" ]; };
      };
    };

    go = {
      enable = true;
      package = pkgs.unstable.go_1_19;
      goPath = "go";
      goBin = "go/bin";
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        set tabstop=2
        set shiftwidth=2
        set number
      '';
    };
  };
}
