{ lib, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.config/oh-my-zsh";
      theme = "maia";

      plugins = [
        "direnv"
        "git"
        "gcloud"
        "history"
        "history-substring-search"
        "zsh-nvm"
        "timer"
      ];

      extraConfig = ''
        HIST_STAMPS="yyyy-mm-dd"

        ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[comment]=fg=8,bold

        TIMER_FORMAT="[%d]"
        TIMER_PRECISION="2"
      '';
    };

    envExtra = "";

    initExtraFirst = ''
      ${lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''
        eval $(/opt/homebrew/bin/brew shellenv)
      ''}
      export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
      export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.emacs.d/bin:$GOBIN:$PATH"
    '';

    initExtraBeforeCompInit = "";

    initExtra = ''
      eval "$(fzf --zsh)"
      BASE16_SHELL="$HOME/.config/base16-shell/"
      [ -n "$PS1" ] && \
          [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
              eval "$("$BASE16_SHELL/profile_helper.sh")"
    '';

    localVariables = { };

    sessionVariables = {
      EDITOR = "nvim";
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      GITHUB_USER = "prahaladramji";
      GITHUB_TOKEN = if pkgs.stdenv.hostPlatform.isDarwin then
        "$(security -q find-generic-password -ws github-public)"
      else
        "";
      HOMEBREW_GITHUB_API_TOKEN =
        lib.optionalString pkgs.stdenv.hostPlatform.isDarwin "\${GITHUB_TOKEN}";
    };

    history = {
      size = 999999999;
      save = 999999999;
    };

    shellAliases = {
      pr = "cd $(git rev-parse --show-toplevel)";
      ls = "ls -AFhl --color=auto";
      flushdns = lib.optionalString pkgs.stdenv.hostPlatform.isDarwin
        "sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder";
      sshkill = if pkgs.stdenv.hostPlatform.isDarwin then
        ''pkill -fl "ssh(uttle -D| -|:)"''
      else
        ''pkill -f "ssh(uttle -D| -|:)"'';
    };
  };

  home.file = {
    ".config/oh-my-zsh/themes/maia.zsh-theme".source = ./maia.zsh-theme;
    ".config/oh-my-zsh/extraconfigs.zsh".source = ./extraconfigs.zsh;
    ".config/oh-my-zsh/fix-paste.zsh".source = ./fix-paste.zsh;

    ".config/oh-my-zsh/tmux-session.zsh".text = ''
      # tmux session wrangling
      function tmux_group_session() {
        GRPSC_GID=''${1:=grpsc}
        GRPSC_CID=''${GRPSC_GID}-$(date +'%H%M%S')
        if ! ${pkgs.tmux}/bin/tmux has-session -t main &>/dev/null; then
          ${pkgs.tmux}/bin/tmux new-session -d -s main
        fi
        ${pkgs.tmux}/bin/tmux new-session -A -t main -s ''${GRPSC_CID} \; set-option destroy-unattached
      }

      # Disabled tmux until fixing the $TERM to support 256 colors
      if [[ $- == *i* ]] && ! [[ -n "''${INTELLIJ_ENVIRONMENT_READER}" || -n "''${TMUX}" || "''${TERM}" =~ "tmux.*" || "''${TERM}" =~ "screen.*" || "''${TERMINAL_EMULATOR}" =~ "JetBrains.*" || "''${TERM_PROGRAM}" == "vscode" ]]; then
        # we are (probably) not in a tmux session or in intellij
        tmux_group_session
        sleep 0.5
        exit
      fi
    '';

    ".config/oh-my-zsh/plugins/zsh-nvm".source = pkgs.fetchFromGitHub {
      owner = "lukechilds";
      repo = "zsh-nvm";
      rev = "23067bd9bb6eb6f4737a3ea90cb0cb5e85f61ba2";
      sha256 = "Zwdi7bezMFKaIKYwsSftu3mJSFvadEWmY2hYnU1Kpu4=";
    };
  };
}
