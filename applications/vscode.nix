{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        brettm12345.nixfmt-vscode
        eamodio.gitlens
        editorconfig.editorconfig
        hashicorp.terraform
        golang.go
        ms-azuretools.vscode-docker
        ms-python.python
        ms-python.vscode-pylance
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "vscode-cuelang";
        publisher = "brody715";
        version = "0.0.4";
        sha256 = "g/xYOvo98A5kqDG3hGtfWC+Ap0JULo8I0ruTtNXpt1o=";
      }];

    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "editor.formatOnSave" = true;
      "files.autoSave" = "onFocusChange";
      "workbench.startupEditor" = "none";
    };
  };
}
