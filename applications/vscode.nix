{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      brettm12345.nixfmt-vscode
      eamodio.gitlens
      editorconfig.editorconfig
      hashicorp.terraform
      golang.go
      ms-azuretools.vscode-docker
      ms-python.python
      ms-python.vscode-pylance
    ];

    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "editor.formatOnSave" = true;
      "files.autoSave" = "onFocusChange";
      "workbench.startupEditor" = "none";
    };
  };
}
