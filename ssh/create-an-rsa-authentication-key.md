How to create an rsa authentication key for authentication on a foreign server
==============================================================================

Create the key
--------------

$ ssh-keygen

This will generate both a private and a public key. They will be stored in *~/.ssh/id_rsa* and *~/.ssh/id_rsa.pub*.

Copy the key to the server
--------------------------

Add the contents of the public key file into *~/.ssh/authorized_keys* on the remote site (the file should be mode 600).

For more information see [www.debian.org](https://www.debian.org/devel/passwordlessssh)
