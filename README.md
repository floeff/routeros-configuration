# routeros-configuration
Configuration files for MikroTik RouterOS

This repository contains my configuration files for various MikroTik RouterOS devices.

The files shared here are **not** ready to use, but must be adapted to your specific needs and scenarios. As your device is likely connected to a public network, mistakes in configuring it can have severe negative impacts.

Before putting a machine into production, [read the documentation](https://help.mikrotik.com/docs/). There is also a [user forum](https://forum.mikrotik.com) available.

I published a series of blogposts and one article on how to use MikroTik RouterOS in German language which you can find [in my blog](https://blog.effenberger.org/category/routeros/).

Feedback, suggestions, improvements and bug reports always welcome!

## Limitations
Although files have the RSC suffix for syntax highlighting, they are **not** suited for automated deployment. You can copy-paste individual configuration lines on the console, but the files have **not been tested for unattended use**. I might work on this, and/or Ansible scripts, at a later stage. Any help is welcome!

## Required software
The scripts are based on RouterOS 7.x. The older and currently LTS version 6.x has a slightly different syntax, against which the scripts have not been tested.

### Upgrading to RouterOS 7.x

To upgrade from RouterOS 6.x to 7.x, you can use the following commands:
```
/system package update set channel=upgrade
/system package update check-for-updates
/system package update download
/system reboot
```

## Demo system
MikroTik provides two demo systems at https://demo.mt.lv and https://demo2.mt.lv which you can use for testing. Not all features of the scripts might be supported.
