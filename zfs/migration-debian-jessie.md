# ZFS Pool Migration to Debian Jessie

This document is about the migration of an existing zfs pool from an older Debian Release to Debian Jessie.

The following steps should be considered:

- Secure a backup of data stored on the zfs pool.
- Exporting the ZFS Pool
- Install Debian Jessie
- Install ZFS Support
- Import and Mount ZFS Pool

## Secure a Backup of the ZFS Pool

## Export the ZFS Pool

To export the storage pool 'tank', use the following command:
```
$ zpool export tank
```

See 
- [exporting zpools](https://pthree.org/2012/12/10/zfs-administration-part-v-exporting-and-importing-zpools/)
- [docs.oracle.com](http://docs.oracle.com/cd/E19253-01/819-5461/gbchy/index.html)

## Install Debian Jessie

Download a disc image at [www.debian.org](https://www.debian.org/distrib/netinst).

## Install zfs-linux Package

Add jessie-backports repository (ZFS packages are in contrib area):
```
$ sudo echo "deb http://ftp.debian.org/debian jessie-backports main contrib" >> /etc/apt/sources.list.d/backports.list
$ sudo aptitude update
```

Install zfs package:
```
$ sudo aptitude install -t jessie-backports zfs-dkms
```

Sources:
- https://github.com/zfsonlinux/zfs/wiki/Debian
- https://www.howtoforge.com/tutorial/how-to-install-and-configure-zfs-on-debian-8-jessie

## Import ZFS Pool
See [docs.oracle.com](http://docs.oracle.com/cd/E19253-01/819-5461/gazuf/index.html)



