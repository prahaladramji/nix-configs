{ lib, pkgs, ... }: {
  programs.git = {
    enable = true;
    lfs = { enable = true; };

    aliases = {
      lg =
        "log --all --decorate --graph --abbrev-commit  --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'";
      tagm = "!git tag -f $1 && git push -f --tags #";
    };

    signing = {
      gpgPath = "${pkgs.gnupg}/bin/gpg";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      url."ssh://git@github.com/".insteadOf = "https://github.com/";

      credential = {
        helper = [ "cache --timeout 30000" "store --file ~/.git-credentials" ]
          ++ lib.optionals pkgs.stdenv.isDarwin [ "osxkeychain" ];
      };
    };

    ignores = [
      "*~"
      # General
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"

      # Icon must end with two \r
      "Icon"

      # Thumbnails
      "._*"

      # Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"

      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      # Jetbrains IDE files
      ".idea/*"

      # vscode files
      ".vscode/*"

      # direnv environment config files
      ".envrc"

      # ignore scratch files and random tests
      "**/scratch/*"
    ];
  };
}
