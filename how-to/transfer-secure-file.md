How to compress and encrypt a file
==================================

Compress the file

    $ tar -czf foo.tgz foo.txt
  
Encrypt the file

    $ gpg -c foo.tgz

Transfer the file

Decrypt the file

    $ gpg foo.tgz.gpg

Uncompress the file

    $ tar -xf foo.tgz
