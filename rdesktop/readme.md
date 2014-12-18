Rdesktop
========

Installation
------------

Rdesktop is a remote desktop client for linux and can be installed via aptitude:

    $ sudo aptitude install rdesktop

Usage
-----

    $ rdesktop -u "domain\user" -x 0x80 -a 32 -g 1920x1080 -r disk:home=/home/username ip_address

### -u "domain\user"

The windows domain and username

### -x 0x80

Connect to Windows 7 and Vista with ClearType font smoothing enabled. For a deeper understanding of this setting see [katastrophos.net](https://katastrophos.net/andre/blog/2008/03/10/rdesktop-connect-to-windows-vista-with-cleartype-font-smoothing-enabled/)

### -a 32

Sets color depth to 32 bit, which is best for Windows 7.

### -g 1920x1080

Sets the resolution to 1920x1080 pixels.

### -r disk:home=/home/username

Creates a disk drive *"home"* on the windows machine that maps to the folder *"/home/username"* on your local linux system.

### ip_address

The ip address of the windows machine you want to connect to.


Additional Options
------------------

### -k de

Set german keyboard layout

### -f

Start rdesktop in fullscreen mode. If used with two monitors rdestop uses both of them for one single window.

### -g 90%

Set the resolution to 90% of the fullscreen resolution. Problematic, if you have more than one monitor.

