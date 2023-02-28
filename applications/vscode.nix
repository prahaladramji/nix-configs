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
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "runonsave";
          publisher = "emeraldwalk";
          version = "0.2.0";
          sha256 = "nPm9bTEnNHzb5omGoEh0e8Wp+XTLW2UTtr/OuSBd99g=";
        }
        {
          name = "cuelang";
          publisher = "nickgo";
          version = "0.0.1";
          sha256 = "dAMV1SQUSuq2nze5us6/x1DGYvxzFz3021++ffQoafI=";
        }
      ];

    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "editor.formatOnSave" = true;
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "files.autoSave" = "onFocusChange";
      "go.toolsManagement.autoUpdate" = true;
      "update.mode" = "none";
      "workbench.startupEditor" = "none";
      "[python]"."editor.formatOnType" = true;
      "emeraldwalk.runonsave"."commands" = [{
        "match" = "\\.cue$";
        "cmd" = "cue fmt -s \${file}";
      }];
    };
  };
}
