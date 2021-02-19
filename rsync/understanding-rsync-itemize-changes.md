_This is an article from [Andrea Francia](http://andreafrancia.it/), which has helped me a lot, when I was migrating data from one server to another. 
It is no longer available, so I made it available here._

Understanding the output of rsync --itemize-changes
===================================================

As you may know the rsync's --delete options if misused could make severe damage.

To prevent this you can use the --itemize-change and the --dry-run options to figure out how the command will behave before launching the real one.

The output will be something like that:

    .d..t..g... ./
    .f...p.g... Something.pdf
    .f.....g... md5sum-2010-02-21.txt
    .f...p.g... prova.rb
    .d.....g... .metadata/
    .f...p.g... .metadata/.lock
    .f...p.g... .metadata/.log
    .f...p.g... .metadata/version.ini
    >f+++++++++ Parameter_Usage.txt

Where the first field of each line tell what rsync would do to each file.

I wrote this little schema that helped me to understand this output format and I'm publishing hoping it will be useful for others.

    YXcstpoguax  path/to/file
    |||||||||||
    `----------- the type of update being done::
     ||||||||||   <: file is being transferred to the remote host (sent).
     ||||||||||   >: file is being transferred to the local host (received).
     ||||||||||   c: local change/creation for the item, such as:
     ||||||||||      - the creation of a directory
     ||||||||||      - the changing of a symlink,
     ||||||||||      - etc.
     ||||||||||   h: the item is a hard link to another item (requires --hard-links).
     ||||||||||   .: the item is not being updated (though it might have attributes that are being modified).
     ||||||||||   *: means that the rest of the itemized-output area contains a message (e.g. "deleting").
     ||||||||||
     `---------- the file type:
      |||||||||   f for a file,
      |||||||||   d for a directory,
      |||||||||   L for a symlink,
      |||||||||   D for a device,
      |||||||||   S for a special file (e.g. named sockets and fifos).
      |||||||||
      `--------- c: different checksum (for regular files)
       ||||||||     changed value (for symlink, device, and special file)
       `-------- s: Size is different
        `------- t: Modification time is different
         `------ p: Permission are different
          `----- o: Owner is different
           `---- g: Group is different
            `--- u: The u slot is reserved for future use.
             `-- a: The ACL information changed
