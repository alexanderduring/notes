# ZFS Pool Migration to Debian Jessie

This document is about the migration of an existing zfs pool from an older Debian Release to Debian Jessie.

The following steps should be considered:

- Secure a backup of data stored on the zfs pool.
- Exporting the ZFS Pool ([docs.oracle.com](http://docs.oracle.com/cd/E19253-01/819-5461/gbchy/index.html))
- Install Debian Jessie
- Install ZFS Support
- Mount ZFS Pool


Sources:
- https://github.com/zfsonlinux/zfs/wiki/Debian
- https://www.howtoforge.com/tutorial/how-to-install-and-configure-zfs-on-debian-8-jessie
