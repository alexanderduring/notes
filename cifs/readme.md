Connect to Samba Share
======================

First create a folder in /media where you want to mount your share. Then edit the file /etc/fstab accordingly.

You also need to have the package cifs-utils installed:

    $ sudo aptitude install cifs-utils

To activate the fstab configuration use

    $ sudo mount -a
