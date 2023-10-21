{ lib, pkgs, ... }: {
  imports = [ ./emacs ./git.nix ./gpg.nix ./ssh.nix ./tmux ./vscode.nix ./zsh ];

  home.packages = with pkgs.unstable;
    [
      argocd
      awscli2
      bazel
      colordiff
      coreutils
      cue
      curlHTTP3
      discord
      docker-compose
      fd
      gh
      gnumake
      go-jsonnet
      google-cloud-sdk
      grpcurl
      htop
      kubernetes-helm
      jq
      jsonnet-language-server
      k9s
      kind
      kubebuilder
      kubecfg
      kubectl
      kubectx
      lego
      moreutils
      nixfmt
      open-policy-agent
      poetry
      pre-commit
      protobuf
      (python310.withPackages (p: with p; [ pre-commit-hooks requests ]))
      (ripgrep.override { withPCRE2 = true; })
      rsync
      source-code-pro
      ssm-session-manager-plugin
      steampipe
      step-ca
      step-cli
      stow
      terraform
      terraform-docs
      tree
      vault
      wget
      whois
      yq-go
    ] ++ lib.optionals stdenv.isLinux [
      _1password
      bc
      dig
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
          {
            key = "Key1";
            mods = "Alt";
            chars = "\\x1B1";
          }
          {
            key = "Key2";
            mods = "Alt";
            chars = "\\x1B2";
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
      stdlib = ''
        layout_poetry() {
          PYPROJECT_TOML="''${PYPROJECT_TOML: -pyproject.toml}"
          if [[ ! -f "$PYPROJECT_TOML" ]]; then
              log_status "No pyproject.toml found. Executing \`poetry init\` to create a \`$PYPROJECT_TOML\` first."
              poetry init --no-interaction --python ^$(python3 --version 2>/dev/null | cut -d' ' -f2 | cut -d. -f1-2)
          fi

          if [[ -d ".venv" ]]; then
              VIRTUAL_ENV="$(pwd)/.venv"
          else
              VIRTUAL_ENV=$(poetry env info --path 2>/dev/null ; true)
          fi

          if [[ -z $VIRTUAL_ENV || ! -d $VIRTUAL_ENV ]]; then
              log_status "No virtual environment exists. Executing \`poetry install\` to create one."
              poetry install
              VIRTUAL_ENV=$(poetry env info --path)
          fi

          PATH_add "$VIRTUAL_ENV/bin"
          export POETRY_ACTIVE=1
          export VIRTUAL_ENV
        }
      '';
    };

    go = {
      enable = true;
      package = pkgs.unstable.go_1_21;
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
