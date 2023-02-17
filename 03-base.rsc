# 03-base.rsc
# Base configuration without IP connectivity

# save license key
# you should copy this file (suffix ".key") to an external storage

/system/license/output


# reset package list, system configuration and MAC addresses

/system/package/uninstall [find name!=routeros]
/system/reset-configuration no-defaults=yes skip-backup=yes keep-users=no
# system now reboots
/ip/dhcp-client/remove [find]
/interface/ethernet/reset-mac-address [find]


# diable PoE out on all ports

:if ($hasPoEOut="1") do={ /interface/ethernet/poe/set poe-out=off [find] }


# disable LCD

:if ($hasLCD="1") do={ /lcd/set enabled=no backlight-timeout=5m read-only-mode=yes touch-screen=disabled }


# create interface lists

/interface/list/add name=layer2-wan
/interface/list/add name=layer2-lan exclude=layer2-wan


# configure ethernet interfaces and create bridges

# on switch, create bridge and add all ports
:if ($MyDeviceType="0") do={
/interface/bridge/add name=bridge1 auto-mac=no admin-mac=[/interface/ethernet/get value-name=mac-address [find where name="ether1"]]
:foreach i in=[/interface/ethernet/find] do={ /interface/bridge/port/add bridge=bridge1 interface=$i }
}

# on router, create bridge and add all ports, except uplink ether1
:if ($MyDeviceType="1") do={
/interface/bridge/add name=bridge1 auto-mac=no admin-mac=[/interface/ethernet/get value-name=mac-address [find where name="ether2"]]
:foreach i in=[/interface/find where name!="ether1"] do={ /interface/bridge/port/add bridge=bridge1 interface=$i }
}

# on switch and access point, configure ethernet interfaces and add to interface list
:if ($MyDeviceType="0" || $MyDeviceType="2") do={
/interface/ethernet/set rx-flow-control=auto tx-flow-control=auto loop-protect=on [find]
:foreach i in=[/interface/find] do={ /interface/list/member/add list=layer2-lan interface=$i }
}

# on router, configure ethernet interfaces and add to interface list, uplink ether1 is in WAN list
:if ($MyDeviceType="1") do={
/interface/ethernet/set rx-flow-control=auto tx-flow-control=auto loop-protect=on [find name!=ether1]
:foreach i in=[/interface/find where name!="ether1"] do={ /interface/list/member/add list=layer2-lan interface=$i }
/interface/list/member/add list=layer2-wan interface=ether1
}


# set hostname

/system/identity/set name=$MyHostname
:if ($hasSwOS="1") do={ /system/swos/set identity=$MyHostname }


# create new system user and set SwOS password

/user/add name=$MyUsername group=full comment="$MyFullname"
# then quit session and relogin with new user
/user/remove admin
:if ($hasSwOS="1") do={ /system/swos/password }


# enable RoMON except on uplink

/tool/romon/set secrets=$MyRoMONSecret
/tool/romon/port/set forbid=no [find]
:if ($MyDeviceType="1") do={ /tool/romon/port/add interface=ether1 forbid=yes disabled=no }
/tool/romon/set enabled=yes


# restrict management services to LAN, but allow SSH from WAN interface

/ip/neighbor/discovery-settings/set discover-interface-list=layer2-lan
/tool/mac-server/set allowed-interface-list=layer2-lan
/tool/mac-server/mac-winbox/set allowed-interface-list=layer2-lan
:if ($MyDeviceType="0" || $MyDeviceType="2") do={ /ip/service/set address="$MyNetwork4,$MyNetwork6" [find] }
:if ($MyDeviceType="1") do={ /ip/service/set address="$MyNetwork4,$MyNetwork6" [find name!=ssh] }
/ip/settings/set tcp-syncookies=yes rp-filter=strict
:if ($hasSwOS="1") do={ /system/swos/set allow-from=$MyNetwork4 }


# tighten SSH configuration and enable strong crypto

/ip/ssh/set strong-crypto=yes
/ip ssh/set allow-none-crypto=no
:if ($MyDeviceType="0" || $MyDeviceType="2") do={ /ip/ssh/set forwarding-enabled=no }
:if ($MyDeviceType="1") do={ /ip/ssh/set forwarding-enabled=local }
/ip/ssh/set host-key-size=4096
/ip/ssh/regenerate-host-key


# only enable required services and use TLSv1.2

/ip/service/disable [find name!=winbox]
/ip/service/enable ssh
/ip/service/set tls-version=only-1.2 [find]
/tool/bandwidth-server/set enabled=no


# disable all optional firewall service ports except FTP on routers

/ip/firewall/service-port/disable [find where name!="udplite" or where name!="dccp" or where name!="sctp"]
:if ($MyDeviceType="1") do={ /ip/firewall/service-port/enable ftp }


# enable graphs from local networks

/tool/graphing/interface add allow-address=$MyNetwork4
/tool/graphing/interface add allow-address=$MyNetwork6
/tool/graphing/queue add allow-address=$MyNetwork4
/tool/graphing/queue add allow-address=$MyNetwork6
/tool/graphing/resource add allow-address=$MyNetwork4
/tool/graphing/resource add allow-address=$MyNetwork6


# save default configuration for reference

/system/default-configuration/print file=([/system/identity/get value-name=name]."-default")
