
Git Cheat Sheet
===============

Branches
--------

Show local branches:

    $ git branch

Show remote branches:
    $ git branch -r

Show information about connection between branches and remote branches:
    $ git branch -vv 

    * develop 834532 [origin/develop] Committed something on develop.
      master  5426d4 [origin/master] Message of last commit on master.

Update your local knowledge about remote branches:
    $ git remote update origin

Update and remove all references to remote branches that do not exist anymore:
    $ git remote update --prune origin


Deleting a remote branch:
    $ git push origin :<remote-branch>
