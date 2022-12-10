{
  imports = [
    ../applications

    # Common Overrides
    ../overrides/git.nix
    ../overrides/ssh.nix
  ];

  programs.home-manager.enable = true;

  home.file = {
    ".config/nix/nix.conf".text = ''
      experimental-features = nix-command flakes
    '';
  };
}
