{ config, pkgs, inputs, ... }:

{
    environment.systemPackages = with pkgs; [
        openvpn # vpn
    ];

    # OPENVPN
    # OPENVPN.optionA run via system
    # enable openvpn
    #services.openvpn.servers = {
    #    officeVPN  = {
    #        config = '' config /home/nolan/Downloads/vpnconfig_cert.ovpn '';
    #        updateResolvConf = true;
    #    };
    #};

    # OPENVPN.optionB enable systemd-resolved for vpn
    # run via `sudo openvpn --config path/to/config`
    # may need to run 
    #       systemctl enable systemd-resolved.service
    #       systemctl start systemd-resolved.service
    services.resolved = {
        enable = true;
    };

    # Need to link to libexec to have update-systemd-resolved
    environment.pathsToLink = [ "/libexec" ];

}

