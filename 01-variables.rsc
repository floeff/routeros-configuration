# 01-variables.rsc
# Configuration of variables for all scripts

# declare variables

:global MyHostname;
:global MyDomain;
:global MySubnet;
:global MyNetwork;
:global MyUsername;
:global MyFullname;
:global MyDeviceType;
:global MyRoMONSecret;
:global MyLCDPIN;
:global MyMikroTikUser;
:global MyMikroTikPassword;
:global MyMikroTikBackupPassword;
:global hasLCD;
:global hasSwOS;
:global hasPoEOut;
:global setSilentMode;


# define variables

:set MyHostname "gateway";
:set MyDomain "intranet";
:set MySubnet "192.168.19";  # the actual device subnet in the main (V)LAN
:set MyNetwork "192.168.0.0/16";  # the subnet for access to management services
:set MyUsername "jjdoe";  # the username to replace the admin user with
:set MyFullname "Jane and John Doe";
:set MyDeviceType "0";  # 0: switch, 1: router without wifi, 2: access point
:set MyRoMONSecret "82384-test-TEST-38592";
:set MyLCDPIN "1590";
:set MyMikroTikUser "test@example.net";  # your MikroTik username for the cloud backup
:set MyMikroTikPassword "38592-TEST-test-82384";  # your MikroTik password for the cloud backup
:set MyMikroTikBackupPassword "38592-test-TEST-82384";  # password for the encrypted cloud backup file, see https://help.mikrotik.com/docs/display/ROS/Cloud#Cloud-Cloudbackup
:set hasLCD "0";  # 0: device has no LCD screen, 1: device has LCD screen
:set hasSwOS "0";  # 0: device is RouterOS only, 1: device is dual-boot with SwOS
:set hasPoEOut "0";  # 0: device does not have PoE out, 1: device has PoE out
:set setSilentMode "0";  # 0: disable silent mode, 1: enable silent mode, see https://wiki.mikrotik.com/wiki/Silent_boot#RouterOS_configuration_2
