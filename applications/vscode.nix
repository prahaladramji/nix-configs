{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    extensions = with pkgs.unstable.vscode-extensions;
      [
        bbenoist.nix
        brettm12345.nixfmt-vscode
        eamodio.gitlens
        editorconfig.editorconfig
        hashicorp.terraform
        github.copilot
        golang.go
        mattn.lisp
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
        {
          name = "hcl";
          publisher = "hashicorp";
          version = "0.3.2";
          sha256 = "cxF3knYY29PvT3rkRS8SGxMn9vzt56wwBXpk2PqO0mo=";
        }
        {
          name = "kcl-vscode-extension";
          publisher = "kcl";
          version = "0.1.3";
          sha256 = "tp26RXL8HCRWCw2y10oaQNhRd6eRyWkyS/A8Rb0bQjk=";
        }
        {
          name = "kusion";
          publisher = "kusionstack";
          version = "0.0.20";
          sha256 = "D9Eq2szXc87QJXSGkt09FGnHud+V6GpvFILAEoFp21M=";
        }
        {
          name = "vscode-jsonnet";
          publisher = "grafana";
          version = "0.5.1";
          sha256 = "qYB5kn/5qAcILywjzaLILxklBJVhSgQSX3rYNCOKvPE=";
        }
      ];

    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "[python]"."editor.formatOnType" = true;
      "editor.formatOnSave" = true;
      "editor.rulers" = [
        {
          "column" = 80;
          "color" = "#5a5a5a80";
        }
        {
          "column" = 120;
          "color" = "#5a5a5a40";
        }
      ];
      "emeraldwalk.runonsave"."commands" = [
        {
          "cmd" = "cue fmt -s \${file}";
          "match" = "\\.cue$";
        }
        {
          "cmd" = "kcl-fmt \${file}";
          "match" = "\\.k$";
        }
      ];
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "files.autoSave" = "onFocusChange";
      "git.autofetch" = true;
      "github.copilot.enable" = {
        "*" = "true";
        "plaintext" = true;
        "scminput" = false;
      };
      "go.toolsManagement.autoUpdate" = true;
      "update.mode" = "none";
      "workbench.startupEditor" = "none";
    };
  };
}
