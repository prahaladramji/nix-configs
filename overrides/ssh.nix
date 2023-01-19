{
  home.file = {
    ".ssh/config.d/00-aws".text = ''
      HOST i-* mi-*
      ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
      User ec2-user
    '';

    ".ssh/config.d/00-home".text = ''
      HOST draco
        HostName draco.home.digitalvagabond.tech
        User administrator

      HOST esx-01
        HostName esx-01.home.digitalvagabond.tech
        User root

      HOST k8s-*
        User ubuntu

      HOST !k8s-*.digitalvagabond.tech k8s-*
        HostName %h.home.digitalvagabond.tech

      HOST raspberrypi
        HostName raspberrypi.home.digitalvagabond.tech
        User pi
    '';
  };
}
