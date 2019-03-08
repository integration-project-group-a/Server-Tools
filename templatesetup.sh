# wget -q https://raw.githubusercontent.com/integration-project-group-a/Server-Tools/master/templatesetup.sh -O templatesetup.sh && chmod +x templatesetup.sh && sudo ./templatesetup.sh && rm templatesetup.sh
#Config file
echo "Installing neofetch"
apt install neofetch

echo "Team name?"
read team
hostname "$team.teams.project.ehb.be"

echo "IPv4 configuration, [10.3.56.] 21 - 39"
read ip
netplan=`cat <<EOF
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        eth0:
            addresses:
            - 10.3.56.${ip}/24
            gateway4: 10.3.56.1
            nameservers:
                addresses:
                - 172.20.0.253
                - 172.20.0.254
    version: 2
EOF
`

echo "${netplan}" > /etc/netplan/50-cloud-init.yaml

sudo netplan apply
