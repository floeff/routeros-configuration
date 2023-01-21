# 02-devices.rsc
# List of devices and their features

# switches

:if ([/system/routerboard/get value-name=model]="CRS125-24G-1S") do={
:set MyDeviceType "0";
:set hasLCD "1";
#no SwOS
#no PoEOut
}

:if ([/system/routerboard/get value-name=model]="CRS226-24G-2S+") do={
:set MyDeviceType "0";
:set hasLCD "1";
#no SwOS
#no PoEOut
}

:if ([/system/routerboard/get value-name=model]="CRS328-24P-4S+") do={
:set MyDeviceType "0";
#no LCD
:set hasSwOS "1";
:set hasPoEOut "1";
}


# routers

# hEX
:if ([/system/routerboard/get value-name=model]="RouterBOARD 750G r3") do={
:set MyDeviceType "1";
#no LCD
#no SwOS
#no PoEOut
}


# access points

# wAP ac
:if ([/system/routerboard/get value-name=model]="RBwAPG-5HacT2HnD") do={
:set MyDeviceType "2";
#no LCD
#no SwOS
#no PoEOut
}

# wAP ac rev. 2
:if ([/system/routerboard/get value-name=model]="RBwAPG-5HacD2HnD") do={
:set MyDeviceType "2";
#no LCD
#no SwOS
#no PoEOut
}

# cAP ac
:if ([/system/routerboard/get value-name=model]="RBcAPGi-5acD2nD") do={
:set MyDeviceType "2";
#no LCD
#no SwOS
:set hasPoEOut "1";
}


# combined devices
# MyDeviceType depends on your use, so adjust to your needs

# mAP lite
:if ([/system/routerboard/get value-name=model]="RouterBOARD mAP L-2nD") do={
:set MyDeviceType "2";
#no LCD
#no SwOS
#no PoEOut
}

:if ([/system/routerboard/get value-name=model]="2011UiAS-2HnD") do={
:set MyDeviceType "2";
:set hasLCD "1";
#no SwOS
:set hasPoEOut "1";
}

:if ([/system/routerboard/get value-name=model]="951G-2HnD") do={
:set MyDeviceType "2";
#no LCD
#no SwOS
#no PoEOut
}
