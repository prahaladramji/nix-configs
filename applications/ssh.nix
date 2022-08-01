{
  programs.ssh = {
    enable = true;
    compression = true;
    controlMaster = "auto";
    controlPath = "/tmp/ssh_mux_%h";
    controlPersist = "3h";
    forwardAgent = true;
    includes = [ "config.d/*" ];
    serverAliveCountMax = 10;
    serverAliveInterval = 60;
    userKnownHostsFile = "/dev/null";

    extraConfig = ''
      AddKeysToAgent yes
      IgnoreUnknown UseKeychain
      LogLevel ERROR
      Protocol 2
      StrictHostKeyChecking no
      UseKeychain yes
    '';
  };
}
