{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;

    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    historyLimit = 100000;
    prefix = "C-a";
    sensibleOnTop = false;
    terminal = "screen-256color";
    extraConfig = builtins.readFile ./tmux.conf;
  };

  xdg.configFile."tmux/kube.tmux".text = builtins.readFile
    (pkgs.fetchFromGitHub {
      owner = "jonmosco";
      repo = "kube-tmux";
      rev = "b661566319519b81bfeeefd61871421fddadc275";
      sha256 = "RD3A5z2YBy9nIcg6TzT4WHMi+UH2+nL6D3rEUvLG4gU=";
    } + "/kube.tmux");
}
